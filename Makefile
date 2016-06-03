first:
	@touch complicated_binary_first.deb

second:
	exit 1
	@touch complicated_binary_second.deb

third:
	@touch complicated_binary_third.deb

.PHONY: first second third