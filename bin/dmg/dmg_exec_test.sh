. dmg
. $SHUNIT2_MOCK

setUp() {
	mock_function sudo
	mock_function if_pipeline "return 1"
	IMAGE_CONTAINER=image_container
}

test_exec_command() {
	dmg_main exec echo 'hello world'

	mock_verify sudo HAS_CALLED_WITH docker exec -it image_container echo 'hello world'
}

test_exec_start_before_exec() {
	mock_function dmg_start
	dmg_main exec echo 'hello world'

	mock_verify dmg_start HAS_CALLED_WITH
	mock_verify sudo HAS_CALLED_WITH docker exec -it image_container echo 'hello world'
}

test_exec_command_in_pipeline() {
	mock_function if_pipeline "return 0"
	dmg_main exec cat
	mock_verify dmg_start HAS_CALLED_WITH
	mock_verify sudo HAS_CALLED_WITH docker exec -i image_container cat
}


. $SHUNIT2_BIN
