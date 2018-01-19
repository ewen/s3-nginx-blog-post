from django.shortcuts import render, get_object_or_404
from django.http import HttpResponse
from .models import File
from urllib.parse import urlparse


def index(request):
    files = File.objects.all()
    return render(request, 'files/index.html', {'files': files})


def download(request, id):
    file = get_object_or_404(File, id=id)
    url = file.remote_url
    file_name = file.file_name
    protocol = urlparse(url).scheme

    # Let NGINX handle it
    response = HttpResponse()
    # The below header tells NGINX to catch it and serve, see docker-config/nginx-app.conf
    response['X-Accel-Redirect'] = '/file_download/' + protocol + '/' + url.replace(protocol + '://', '')
    response['Content-Disposition'] = 'attachment; filename="{}"'.format(file_name)
    return response
