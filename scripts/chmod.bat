git update-index --chmod=+x ..\rootfs\usr\local\bin\docker_entrypoint.sh
git update-index --chmod=+x ..\rootfs\usr\local\bin\docker_healthcheck.sh
git ls-files --stage
git commit -m "chmod +x"
