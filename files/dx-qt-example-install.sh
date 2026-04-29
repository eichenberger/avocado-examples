#!/usr/bin/env bash

# AVOCADO_BUILD_EXT_SYSROOT: The sysroot of the extension being installed into

set -e

echo "============================================"
echo "Installing DeepX Qt5 example into extension"
echo "============================================"

QT_STAGING="${AVOCADO_BUILD_DIR}/dx-qt-example-staging"

if [ ! -d "$QT_STAGING/usr/local" ]; then
    echo "ERROR: Staging directory not found: $QT_STAGING"
    echo "Run the compile step first."
    exit 1
fi

echo "Copying qt-deepx-example binary..."
cp -a "$QT_STAGING/usr" "$AVOCADO_BUILD_EXT_SYSROOT/"

# Install the systemd service unit
SERVICE_DIR="${AVOCADO_BUILD_EXT_SYSROOT}/usr/lib/systemd/system"
mkdir -p "$SERVICE_DIR"

if [ -f "${AVOCADO_BUILD_DIR}/qt-deepx-example/service/qt-deepx-example.service" ]; then
    install -m 0644 "${AVOCADO_BUILD_DIR}/qt-deepx-example/service/qt-deepx-example.service" "$SERVICE_DIR/"
elif [ -f "qt-deepx-example/service/qt-deepx-example.service" ]; then
    install -m 0644 "qt-deepx-example/service/qt-deepx-example.service" "$SERVICE_DIR/"
else
    echo "WARNING: qt-deepx-example.service not found; skipping service installation"
fi

echo "qt-deepx-example installed successfully!"
echo "  Binary:  ${AVOCADO_BUILD_EXT_SYSROOT}/usr/local/bin/qt_deepx_example"
echo "  Service: ${SERVICE_DIR}/qt-deepx-example.service"
