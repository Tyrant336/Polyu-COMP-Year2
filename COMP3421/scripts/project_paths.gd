class_name ProjectPaths
extends RefCounted

const EXAMPLE_HTTP := "res://example.http"


static func resolve_exact_folder(folder: String = "") -> String:
	if folder.is_empty() or folder == "res://":
		if FileAccess.file_exists(EXAMPLE_HTTP):
			return ProjectSettings.globalize_path(EXAMPLE_HTTP).get_base_dir()
		return _find_folder_with_project_godot(ProjectSettings.globalize_path("res://"))

	var var_path := folder.strip_edges()
	if var_path.is_empty():
		return ""

	if var_path.begins_with("res://"):
		var abs_res := ProjectSettings.globalize_path(var_path)
		if FileAccess.file_exists(var_path) and not var_path.ends_with("/"):
			return abs_res.get_base_dir()
		return _find_folder_with_project_godot(abs_res)

	return _find_folder_with_project_godot(var_path.replace("\\", "/"))


static func _find_folder_with_project_godot(start_path: String) -> String:
	var current := start_path.replace("\\", "/").rstrip("/")

	for _i in range(16):
		if FileAccess.file_exists(current + "/project.godot"):
			return current + "/"
		var parent := current.get_base_dir().replace("\\", "/").rstrip("/")
		if parent == current or parent.is_empty():
			break
		current = parent

	return start_path.replace("\\", "/").rstrip("/") + "/"


static func path_to_file_uri(path: String) -> String:
	var normalized := path.replace("\\", "/")
	if not normalized.ends_with("/"):
		normalized += "/"

	if normalized.length() >= 2 and normalized[1] == ":":
		var drive := normalized.substr(0, 2)
		var rest := normalized.substr(3)
		var segments: PackedStringArray = []
		for segment in rest.split("/", false):
			segments.append(segment.uri_encode())
		return "file:///" + drive + "/" + "/".join(segments) + "/"

	if normalized.begins_with("//"):
		return "file:" + normalized.uri_encode()

	return "file://" + normalized.uri_encode()
