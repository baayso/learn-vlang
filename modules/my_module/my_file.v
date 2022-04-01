module my_module

pub const golden_ratio = 1.61803

fn init() {
	println('my_module init...')	
}

struct User {
	a int // private immutable (default)
	name string
mut:
	b int // private mutable
	c int // (you can list multiple fields with the same access modifier)
	is_registered bool
pub:
	d int // public immutable (readonly)
pub mut:
	e int // public, but mutable only in parent module
}

pub fn new_user(name string, d int) &User {
	return &User{name: name, d: d}
}

// 会在每个变量的生命周期结束时静态插入对数据类型 free() 的调用
[unsafe]
fn (u &User) free() {
	// ...
}

// error: use `(mut f Foo)` or `(f &Foo)` instead of `(mut f &Foo)`

pub fn (mut u User) register() {
	u.is_registered = true
}

pub fn (u User) is_registered() bool {
	return u.is_registered
}

pub fn (u User) get_name() string {
	return u.name
}
