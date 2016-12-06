. dmg

. $SHUNIT2_MOCK

setUp() {
	mock_function sudo
	IMAGE_CONTAINER=image_container
}

test_delete_image() {
	mock_function dmg_exit
	dmg_main delete

	mock_verify dmg_exit HAS_CALLED_WITH
	mock_verify sudo HAS_CALLED_WITH docker rmi -f image_container
}

test_delete_image_with_image_name() {
	DOCKER_IMAGE=image
	dmg_main delete

	mock_verify sudo HAS_CALLED_WITH docker rmi -f image
}

test_delete_image_with_repo_and_version() {
	DOCKER_REPO=repo/
	IMAGE_VERSION=100
	DOCKER_IMAGE=image
	dmg_main delete

	mock_verify sudo HAS_CALLED_WITH docker rmi -f repo/image:100
}


. $SHUNIT2_BIN
