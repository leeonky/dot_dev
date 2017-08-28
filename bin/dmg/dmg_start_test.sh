. dmg
. $SHUNIT2_MOCK

setUp() {
	mock_function sudo ''
	mock_function sleep ''
	DOCKER_IMAGE=docker_image
	IMAGE_CONTAINER=image_container
	unset DOCKER_REPO
	unset WORKING_USER
	unset WORKING_DIR
	unset WORKING_ADDR
	unset IMAGE_VERSION
	unset EXPOSE_PORTS
	unset VOLUMNS
	unset START_COMMANDS
	unset DISPLAY
	unset HOSTS_MAPPING
	unset WORKING_ENV
}

test_start_container_only_with_name() {
	dmg_main start

	mock_verify sudo HAS_CALLED_WITH docker run -d --name image_container --privileged=true -h image_container docker_image
}

test_start_container_only_with_shm_size() {
	SHM_SIZE=1G

	dmg_main start

	mock_verify sudo HAS_CALLED_WITH docker run -d --name image_container --privileged=true --shm-size 1G -h image_container docker_image
}

test_start_container_only_with_no_docker_image() {
	unset DOCKER_IMAGE
	dmg_main start

	mock_verify sudo HAS_CALLED_WITH docker run -d --name image_container --privileged=true -h image_container image_container
}

test_start_container_with_host_name() {
	CONTAINER_HOST='test'
	dmg_main start

	mock_verify sudo HAS_CALLED_WITH docker run -d --name image_container --privileged=true -h test docker_image
}

test_start_container_with_docker_repo() {
	DOCKER_REPO=daocloud.io/leeonky/

	dmg_main start

	mock_verify sudo HAS_CALLED_WITH docker run -d --name image_container --privileged=true -h image_container daocloud.io/leeonky/docker_image
}

test_start_container_with_user() {
	WORKING_USER=user

	dmg_main start

	mock_verify sudo HAS_CALLED_WITH docker run -d --name image_container --privileged=true -h image_container -u user docker_image
}

test_start_container_with_working_dir() {
	WORKING_DIR='/test with space/'

	dmg_main start

	mock_verify sudo HAS_CALLED_WITH docker run -d --name image_container --privileged=true -h image_container -w '/test with space/' docker_image
}

test_start_container_with_work_addr() {
	WORKING_ADDR='127.0.0.1:/test with space/'

	dmg_main start

	mock_verify sudo HAS_CALLED_WITH docker run -d --name image_container --privileged=true -h image_container -e "WORKING_ADDR=127.0.0.1:/test with space/" docker_image
}

test_start_container_with_display() {
	DISPLAY='127.0.0.1:0'

	dmg_main start

	mock_verify sudo HAS_CALLED_WITH docker run -d --name image_container --privileged=true -h image_container -e "DISPLAY=127.0.0.1:0" docker_image
}

test_start_container_with_image_version() {
	IMAGE_VERSION=1.0.1
	dmg_main start

	mock_verify sudo HAS_CALLED_WITH docker run -d --name image_container --privileged=true -h image_container docker_image:1.0.1
}

test_start_container_with_one_expose_port() {
	EXPOSE_PORTS=80
	dmg_main start

	mock_verify sudo HAS_CALLED_WITH docker run -d --name image_container --privileged=true -h image_container -p 80 docker_image
}

test_start_container_with_two_expose_ports() {
	EXPOSE_PORTS=('80' '81')
	dmg_main start

	mock_verify sudo HAS_CALLED_WITH docker run -d --name image_container --privileged=true -h image_container -p 80 -p 81 docker_image
}

test_start_container_with_one_volumn() {
	VOLUMNS='/a:/a'
	dmg_main start

	mock_verify sudo HAS_CALLED_WITH docker run -d --name image_container --privileged=true -h image_container -v '/a:/a' docker_image
}

test_start_container_with_two_volumns() {
	VOLUMNS=('/a:/a' '/b:/b')
	dmg_main start

	mock_verify sudo HAS_CALLED_WITH docker run -d --name image_container --privileged=true -h image_container -v '/a:/a' -v '/b:/b' docker_image
}

test_start_container_with_command() {
	START_COMMANDS=('echo' 'hello world')
	dmg_main start

	mock_verify sudo HAS_CALLED_WITH docker run -d --name image_container --privileged=true -h image_container docker_image echo 'hello world'
}

test_nothing_for_running_container() {
	mock_function sudo 'echo image_container'
	dmg_main start

	mock_verify sudo ONLY_CALLED_WITH docker ps
}

test_start_container_with_one_hosts_mapping() {
	HOSTS_MAPPING=('l:127.0.0.1')
	dmg_main start

	mock_verify sudo HAS_CALLED_WITH docker run -d --name image_container --privileged=true -h image_container --add-host=l:127.0.0.1 docker_image
}

test_start_stopped_container() {
	mock_function sudo '
	if [ "$*" == "docker ps -a" ]; then
		echo image_container
	fi'

	dmg_main start

	mock_verify sudo CALL_LIST_START
	mock_verify sudo CALLED_WITH_ARGS docker ps
	mock_verify sudo CALLED_WITH_ARGS docker ps -a
	mock_verify sudo CALLED_WITH_ARGS docker start image_container
}

test_start_container_with_env() {
	WORKING_ENV=('a=b' 'c=d')
	dmg_main start

	mock_verify sudo HAS_CALLED_WITH docker run -d --name image_container --privileged=true -h image_container -e 'a=b' -e 'c=d' docker_image
}

. $SHUNIT2_BIN
