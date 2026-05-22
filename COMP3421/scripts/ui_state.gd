class_name UiState
extends RefCounted


static func is_blocking() -> bool:
	if DialogueUI.instance != null and DialogueUI.instance.is_open():
		return true
	if HttpPopupUI.instance != null and HttpPopupUI.instance.is_open():
		return true
	if ChatUI.instance != null and ChatUI.instance.is_open():
		return true
	return false
