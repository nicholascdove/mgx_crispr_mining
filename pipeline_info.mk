ifeq ($(STAGE), dev)
	PIPELINE=awsbatch_run_cctyper_dev
	STACK_NAME=AwsBatchRunCctyper-dev
else ifeq ($(STAGE), prod)
	PIPELINE=awsbatch_run_cctyper
	STACK_NAME=AwsBatchRunCctyper
endif
