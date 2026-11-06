local language_settings = {
	updateImportsOnFileMove = { enabled = "always" },
	suggest = { completeFunctionCalls = true },
	inlayHints = {
		enumMemberValues = { enabled = true },
		functionLikeReturnTypes = { enabled = true },
		parameterNames = { enabled = "literals" },
		parameterTypes = { enabled = true },
		propertyDeclarationTypes = { enabled = true },
		variableTypes = { enabled = false },
	},
}

return {
	settings = {
		complete_function_calls = true,
		vtsls = {
			autoUseWorkspaceTsdk = true,
			enableMoveToFileCodeAction = true,
			experimental = {
				maxInlayHintLength = 30,
				completion = { enableServerSideFuzzyMatch = true },
			},
		},
		typescript = language_settings,
		javascript = language_settings,
	},
}
