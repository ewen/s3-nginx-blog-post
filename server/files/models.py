from django.db import models


class File(models.Model):
    file_name = models.CharField(max_length=100)
    file_size = models.IntegerField()
    mime_type = models.CharField(max_length=50)
    remote_url = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.file_name
