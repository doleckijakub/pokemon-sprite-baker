IMAGE_URL := https://veekun.com/static/pokedex/downloads/heartgold-soulsilver.png
IMAGE_FILE := heartgold-soulsilver.png
CROP_SIZE := 80x80
ROWS := 18
COLUMNS := 28
TOTAL_IMAGES := 493

crop: $(IMAGE_FILE)
	mkdir -p sprites
	@count=0;
	for i in $$(seq 0 $$(($(ROWS) - 1))); do \
		for j in $$(seq 0 $$(($(COLUMNS) - 1))); do \
			index=$$(($$i * $(COLUMNS) + $$j + 1)); \
			if [ $$index -le $(TOTAL_IMAGES) ]; then \
				magick $(IMAGE_FILE) -crop $(CROP_SIZE)+$$((j * 80))+$$((i * 80)) -scale 200% +repage sprites/pokemon_$$index.png; \
				count=$$(($$count + 1)); \
				echo "Progress: $$count/$(TOTAL_IMAGES)"; \
			fi; \
		done; \
	done

$(IMAGE_FILE):
	curl -o $(IMAGE_FILE) $(IMAGE_URL)

clean:
	rm -f $(IMAGE_FILE)
	rm -rf sprites

.PHONY: crop clean
