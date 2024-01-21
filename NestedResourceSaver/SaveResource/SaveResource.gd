extends Resource
class_name SavedTestResource

const RESOURCE_SAVE_DIR : String = "res://"


@export var resource_to_save : ParentResource
	
	
func write_save():
	ResourceSaver.save(self, str(RESOURCE_SAVE_DIR + "test_save.res"))
	print("Saved as ", str(RESOURCE_SAVE_DIR + "test_save.res"))
	

func load_save() -> SavedTestResource:
	return ResourceLoader.load(str(RESOURCE_SAVE_DIR + "test_save.res"), "", ResourceLoader.CACHE_MODE_IGNORE)


func save_exists() -> bool:
	return ResourceLoader.exists(str(RESOURCE_SAVE_DIR + "test_save.res"))
