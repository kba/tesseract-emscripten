LEPT_DIR = ../leptonica-1.72

glue: tesseract.idl
	python $(EMSCRIPTEN)/tools/webidl_binder.py tesseract.idl glue

lepton:
	cd $(LEPT_DIR); \
	emconfigure ./configure --enable-shared=no --disable-programs --without-zlib --without-libpng --without-jpeg --without-giflib --without-libtiff; \
	emmake make

node: glue
	emcc -Oz --closure 1 \
		wrapper.cpp ../api/baseapi.cpp \
		-o lengle.js \
		--post-js glue.js --post-js anterior.js \
		-I$(LEPT_DIR)/src \
		-I../api -I../cube -I../opencl -I../ccutil -I../textord -I../classify -I../dict -I../ccmain -I../cutil -I../wordrec -I../ccstruct  -I../viewer \
		../ccmain/*.cpp ../ccutil/*.cpp   ../wordrec/*.cpp ../textord/*.cpp ../ccstruct/*.cpp ../dict/*.cpp ../cutil/*.cpp ../classify/*.cpp \
		-DANDROID_BUILD -DGRAPHICS_DISABLED \
		-DGRAPHICS_DISABLED -DIMGUNPK_H -DSECURE_NAMES -DTESSDATA_PREFIX="./" -DUSE_STD_NAMESPACE  \
		--memory-init-file 0 -s TOTAL_MEMORY=268435456 \
		-s EXPORT_NAME='"TesseractCore"'  -s MODULARIZE=1 \
		-s EXPORTED_FUNCTIONS='["_pixDestroy","_boxaDestroy","_pixaDestroy","_ptaDestroy"]' \
		--js-transform "python strip_node.py" \
		--llvm-lto 1 -s INVOKE_RUN=0 -s NO_EXIT_RUNTIME=1 -s AGGRESSIVE_VARIABLE_ELIMINATION=1 

dev: glue
	-rm $(LEPT_DIR)/src/freetype.*
	emcc -Oz --closure 1 \
		-Wno-deprecated-register \
		-Wno-undefined-bool-conversion \
		"-Wno-#warnings" \
		wrapper.cpp ../api/baseapi.cpp \
		-o madeline.js \
		--post-js glue.js --post-js anterior.js \
		$(LEPT_DIR)/src/*.c \
		-I$(LEPT_DIR)/src \
		-I../api -I../cube -I../opencl -I../ccutil -I../textord -I../classify -I../dict -I../ccmain -I../cutil -I../wordrec -I../ccstruct  -I../viewer \
		../ccmain/*.cpp ../ccutil/*.cpp   ../wordrec/*.cpp ../textord/*.cpp ../ccstruct/*.cpp ../dict/*.cpp ../cutil/*.cpp ../classify/*.cpp \
		-DANDROID_BUILD -DGRAPHICS_DISABLED \
		-DIMGUNPK_H \
		-DSECURE_NAMES \
		-DTESSDATA_PREFIX="./" -DUSE_STD_NAMESPACE  \
		--memory-init-file 0 -s TOTAL_MEMORY=268435456 \
		-s EXPORT_NAME='"TesseractCore"' \
		-s MODULARIZE=1

module:
	cp lengle.js tesseract.js-core/index.js
	echo "module.exports = TesseractCore;" >> tesseract.js-core/index.js
