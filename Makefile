first: artefactpath
	@touch artefacts/complicated_binary_first.deb

second: artefactpath
	@touch artefacts/complicated_binary_second.deb

third: artefactpath
	@touch artefacts/complicated_binary_third.deb

artefactpath:
	@mkdir --parents artefacts

.PHONY: first second third artefactpath
