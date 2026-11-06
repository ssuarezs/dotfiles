local IGNORE_EMPTY_RULES = { lint = { emptyRules = "ignore" } }

return {
	settings = {
		css = IGNORE_EMPTY_RULES,
		scss = IGNORE_EMPTY_RULES,
		less = IGNORE_EMPTY_RULES,
	},
}
