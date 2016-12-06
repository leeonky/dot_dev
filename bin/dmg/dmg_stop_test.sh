. dmg
. $SHUNIT2_MOCK

setUp() {
	mock_function sudo
	IMAGE_CONTAINER=image_container
}

test_stop_container() {
	dmg_main stop

	mock_verify sudo HAS_CALLED_WITH docker stop image_container
}


. $SHUNIT2_BIN
