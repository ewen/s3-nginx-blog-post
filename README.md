# NGINX's X-Accel with Remote URLs

This is a simple application showing a pattern for using NGINX's X-Accel with remote URLs. See the blog post at https://www.mediasuite.co.nz/blog/proxying-s3-downloads-nginx/.

## Starting the container

Either build the image and run yourself or use a prebuilt image.

### Building your own

Build the image:

`docker build --tag=s3-nginx-blog-post .`

Run the container:

`docker run --rm -p 8888:80 --name=nginx_test s3-nginx-blog-post`

### Using a prebuilt image

Run the container:

`docker run --rm -p 8888:80 --name=nginx_test ewen/s3-nginx-blog-post`

## Connecting

Browse to http://localhost:8888, set up new downloads in the Admin pages http://localhost:8888/admin/.

Admin user is `admin` and password is `s3-nginx-blog-post`.
 
