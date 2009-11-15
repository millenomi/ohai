
typedef struct {
	int red, green, blue, alpha;
} OIColor;

static inline OIColor OIColorMakeInt(int r, int g, int b, int a) {
	OIColor c;
	c.red = r; c.green = g;
	c.blue = b;	c.alpha = a;
	return c;
}

// 0.0-1.0 for all parameters
static inline OIColor OIColorMake(float r, float g, float b, float a) {
	return OIColorMakeInt(r * 255, g * 255, b * 255, a * 255);
}

static inline OIColor OIColorMakeGray(float gray, float alpha) {
	return OIColorMake(gray, gray, gray, alpha);
}

#define OIColorWhite OIColorMakeGray(1.0, 1.0)
#define OIColorBlack OIColorMakeGray(0.0, 1.0)
#define OIColorClear OIColorMakeGray(0.0, 0.0)
