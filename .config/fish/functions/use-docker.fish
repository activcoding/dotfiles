function use-docker
    set -e DOCKER_HOST
    echo "Switched to Docker Desktop (DOCKER_HOST unset)."
    # If unsetting doesn't work, use this instead:
    # set -gx DOCKER_HOST "unix:///var/run/docker.sock"
    # echo "Switched to Docker Desktop. DOCKER_HOST=$DOCKER_HOST"
end
