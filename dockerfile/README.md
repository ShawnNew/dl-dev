## Docker image for deep-learning development.
There are two directories in this folder, which are `gpu` and `cpu` respectively. These means whether the image support CUDA.

To build the already-cooked image, run `docker build -t "${USER}/${IMAGE_NAME}:${VERSION} ."` in a specific directory.
### Some notes:
* You can read the reference about docker capability by invoking `docker --help` or check this [websit](https://docs.docker.com/reference/).
* The `-t` parameter is used to tag the iamge for later use.
* `${USER}` is an environment variable already set in ubuntu environment.
* `${IMAGE_NAME}` and `${VERSION}` may not be set perfectly, so you need to **`IMAGE_NAME=your-specific-name`** and **`VERSION=your-specific-version`**.
