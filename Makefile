.PHONY: phony

email_pw_post_requests_awk: phony ## awk scripting template with variables, functions, and filters
	vim email_pw_post_requests.awk


help: phony ## List all targets and short descriptions of each
	@grep -E '^[^ .]+: .*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk '\
			BEGIN { FS = ": .*##" };\
			{ printf "$(BLUE)%-29s$(RESET) %s\n", $$1, $$2  }'
