#!/usr/bin/env bash
set -e
INPUT_DIR=github.com/intel/multus-cni/types/v1
OUTPUT_DIR=github.com/intel/multus-cni/generated
echo "Generating deepcopy funcs"
"${GOPATH}/bin/deepcopy-gen" --input-dirs "${INPUT_DIR}" -O zz_generated.deepcopy "$@"
echo "Generating clientset"
"${GOPATH}/bin/client-gen" --clientset-name versioned --input-base "" --input "${INPUT_DIR}" --output-package "${OUTPUT_DIR}/clientset" "$@"
echo "Generating listers"
"${GOPATH}/bin/lister-gen" --input-dirs "${INPUT_DIR}" --output-package "${OUTPUT_DIR}/listers" "$@"
echo "Generating informers"
"${GOPATH}/bin/informer-gen" \
            --input-dirs "${INPUT_DIR}" \
            --versioned-clientset-package "clientset/versioned" \
            --listers-package "${OUTPUT_DIR}/listers" \
            --output-package "${OUTPUT_DIR}/informers" \ "$@"
