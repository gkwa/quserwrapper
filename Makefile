run:
	pwsh -file main.ps1

test:
	pwsh -file tests/test.ps1

install:
	cd installer && make clean && make && make install
