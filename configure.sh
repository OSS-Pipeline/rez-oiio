#!/usr/bin/bash

# Will exit the Bash script the moment any command will itself exit with a non-zero status, thus an error.
set -e

EXTRACT_PATH=$1
BUILD_PATH=$2
INSTALL_PATH=${REZ_BUILD_INSTALL_PATH}
OIIO_VERSION=${REZ_BUILD_PROJECT_VERSION}

# We print the arguments passed to the Bash script.
echo -e "\n"
echo -e "================="
echo -e "=== CONFIGURE ==="
echo -e "================="
echo -e "\n"

echo -e "[CONFIGURE][ARGS] EXTRACT PATH: ${EXTRACT_PATH}"
echo -e "[CONFIGURE][ARGS] BUILD PATH: ${BUILD_PATH}"
echo -e "[CONFIGURE][ARGS] INSTALL PATH: ${INSTALL_PATH}"
echo -e "[CONFIGURE][ARGS] OIIO VERSION: ${OIIO_VERSION}"

# We check if the arguments variables we need are correctly set.
# If not, we abort the process.
if [[ -z ${EXTRACT_PATH} || -z ${BUILD_PATH} || -z ${INSTALL_PATH} || -z ${OIIO_VERSION} ]]; then
    echo -e "\n"
    echo -e "[CONFIGURE][ARGS] One or more of the argument variables are empty. Aborting..."
    echo -e "\n"

    exit 1
fi

# We run the configuration script of OIIO.
echo -e "\n"
echo -e "[CONFIGURE] Running the configuration script from OIIO-${OIIO_VERSION}..."
echo -e "\n"

mkdir -p ${BUILD_PATH}
cd ${BUILD_PATH}

# sed "s|find_package (PythonLibs \${PYTHON_VERSION} REQUIRED)|find_package (Python \${PYTHON_VERSION} REQUIRED COMPONENTS Interpreter Development NumPy)|1" --in-place ${EXTRACT_PATH}/src/python/CMakeLists.txt

cmake \
    ${BUILD_PATH}/.. \
    -DCMAKE_INSTALL_PREFIX=${INSTALL_PATH} \
    -DCMAKE_C_FLAGS=-fPIC \
    -DCMAKE_CXX_FLAGS=-fPIC \
    -DCMAKE_POLICY_DEFAULT_CMP0072=NEW \
    -DCMAKE_POLICY_DEFAULT_CMP0074=NEW \
    -DVERBOSE=ON \
    -DOIIO_BUILD_TOOLS=ON \
    -DOIIO_BUILD_TESTS=OFF \
    -DUSE_OPENGL=OFF \
    -DUSE_QT=OFF \
    -DUSE_PYTHON=ON \
    -DPYTHON_VERSION=${REZ_PYTHON_MAJOR_VERSION}.${REZ_PYTHON_MINOR_VERSION} \
    -DUSE_FIELD3D=OFF \
    -DUSE_FFMPEG=OFF \
    -DUSE_OPENJPEG=ON \
    -DUSE_OCIO=OFF \
    -DUSE_OPENCV=OFF \
    -DUSE_OPENSSL=OFF \
    -DUSE_FREETYPE=OFF \
    -DUSE_GIF=OFF \
    -DUSE_PTEX=ON \
    -DUSE_LIBRAW=OFF \
    -DUSE_NUKE=OFF \
    -DUSE_LIBCPLUSPLUS=OFF \
    -DZLIB_ROOT=${REZ_ZLIB_ROOT} \
    -DPNG_ROOT=${REZ_PNG_ROOT} \
    -DTIFF_ROOT=${REZ_TIFF_ROOT} \
    -DILMBASE_INCLUDE_PATH=${REZ_ILMBASE_ROOT}/include \
    -DOPENEXR_INCLUDE_PATH=${REZ_OPENEXR_ROOT}/include \
    -DBOOST_ROOT=${REZ_BOOST_ROOT} \
    -DPTEX_LOCATION=${REZ_PTEX_ROOT} \
    -DJPEG_ROOT=${REZ_JPEG_ROOT} \
    -DOPENJPEG_HOME=${REZ_OPENJPEG_ROOT}

echo -e "\n"
echo -e "[CONFIGURE] Finished configuring OIIO-${OIIO_VERSION}!"
echo -e "\n"
