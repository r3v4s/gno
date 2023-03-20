package big


type Int struct {
	neg bool
	abs nat
	// type nat []Word
}

var intOne = &Int{false, natOne}


//	-1 if x <  0
//	 0 if x == 0
//	+1 if x >  0
func (x *Int) Sign() int {
	// This function is used in cryptographic operations. It must not leak
	// anything but the Int's sign and bit size through side-channels. Any
	// changes must be reviewed by a security expert.
	if len(x.abs) == 0 {
		return 0
	}
	if x.neg {
		return -1
	}
	return 1
}


// NewInt allocates and returns a new Int set to x.
func NewInt(x int64) *Int {
	// This code is arranged to be inlineable and produce
	// zero allocations when inlined. See issue 29951.
	u := uint64(x)
	
	if x < 0 {
		u = -u
	}
	var abs []Word
	
	if x == 0 {
		// r3v4
		// abs = []Word{0}
	} else if _W == 32 && u>>32 != 0 {
		abs = []Word{Word(u), Word(u >> 32)}
	} else {
		abs = []Word{Word(u), Word(u)}
	}
	return &Int{neg: x < 0, abs: abs}
}


// Add sets z to the sum x+y and returns z.
func (z *Int) Add(x, y *Int) *Int {
	neg := x.neg
	if x.neg == y.neg {
		// x + y == x + y
		// (-x) + (-y) == -(x + y)
		
		// println("x.abs:", x.abs)
		// println("y.abs:", y.abs)
		// println("z.abs:", z.abs)

		// z.abs = z.abs.add(x.abs, y.abs) // ORIG XXX
		var _xabs nat = x.abs
		var _yabs nat = y.abs
		var _zabs nat = z.abs
		z.abs = _zabs.add(_xabs, _yabs)
	} else {
		// x + (-y) == x - y == -(y - x)
		// (-x) + y == y - x == -(x - y)
		if x.abs.cmp(y.abs) >= 0 {
			z.abs = z.abs.sub(x.abs, y.abs)
		} else {
			neg = !neg
			z.abs = z.abs.sub(y.abs, x.abs)
		}
	}
	z.neg = len(z.abs) > 0 && neg // 0 has no sign
	return z
}