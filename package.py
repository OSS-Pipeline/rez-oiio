name = "oiio"

version = "1.8.17"

authors = [
    "Sony Pictures Imageworks"
]

description = \
    """
    OpenImageIO is a library for reading and writing images, and a bunch of related classes, utilities, and
    applications. There is a particular emphasis on formats and functionality used in professional, large-scale
    animation and visual effects work for film. OpenImageIO is used extensively in animation and VFX studios all
    over the world, and is also incorporated into several commercial products.
    """

requires = [
    "boost-1.53+",
    "cmake-3+",
    "gcc-6+",
    "glew-2+",
    "ilmbase-2.2+<2.4",
    "jpeg_turbo-2+",
    "numpy-1.12+",
    "openexr-2.2+<2.4",
    "openjpeg-2+",
    "pugixml-1+",
    "pybind11-2.2+",
    "python-2.7+<3",
    "tiff-4+",
    "zlib-1.2+"
]

variants = [
    ["platform-linux"]
]

tools = [
    "iconvert",
    "idiff",
    "igrep",
    "iinfo",
    "maketx",
    "oiiotool"
]

build_system = "cmake"

with scope("config") as config:
    config.build_thread_count = "logical_cores"

uuid = "oiio-{version}".format(version=str(version))

def commands():
    env.PATH.prepend("{root}/bin")
    env.LD_LIBRARY_PATH.prepend("{root}/lib64")
    env.PYTHONPATH.prepend("{root}/lib64/python" + str(env.REZ_PYTHON_MAJOR_VERSION) + "." + str(env.REZ_PYTHON_MINOR_VERSION) + "/site-packages")

    # Helper environment variables.
    env.OIIO_BINARY_PATH.set("{root}/bin")
    env.OIIO_INCLUDE_PATH.set("{root}/include")
    env.OIIO_LIBRARY_PATH.set("{root}/lib64")
