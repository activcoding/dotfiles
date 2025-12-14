function use-podman
    set -gx DOCKER_HOST "unix://"(podman machine inspect --format '{{.ConnectionInfo.PodmanSocket.Path}}')
    echo "Switched to Podman. DOCKER_HOST=$DOCKER_HOST"
end
