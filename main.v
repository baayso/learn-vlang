module main

import os
import time
import my_module as mymod

fn main() {
	println('text')
	println(os.args)

	println(add(77, 33))
	println(sub(100, 50))

	res_1, res_2 := foo(100, 50)
	res_3, _ := foo(100, 50)
	println("$res_1, $res_2, $res_3")
	println('${res_1}, $res_2, $res_3')

	// Variables
	large_number := i64(9999999999)
	println(large_number)

	// Mutable variables
	mut age := 20
	println(age)
	age = 21
	println(age)

	mut aa := 0
	mut bb := 1
	println('$aa, $bb') // 0, 1
	aa, bb = bb, aa
	println('$aa, $bb') // 1, 0

	u := u16(12)
	v := 13 + u    // v is of type `u16` - no promotion
	x := f32(45.6)
	y := x + 3.14  // x is of type `f32` - no promotion
	a := 75        // a is of type `int` - default for int literal
	b := 14.7      // b is of type `f64` - default for float literal
	c := u + a     // c is of type `int` - automatic promotion of `u`'s value
	d := b + x     // d is of type `f64` - automatic promotion of `x`'s value

	println(v)
	println(y)
	println(c)
	println(d)

	println('===========================================================')

	// Strings
	name := 'Bob'
	println('Hello, $name!')
	println('${name.len == 3}')
	assert name.len == 3       // will print 3
	assert name[0] == byte(66) // indexing gives a byte, byte(66) == `B`
	assert byte(66) == `B`
	assert name[1..3] == 'ob'  // slicing gives a string 'ob'

	// escape codes
	windows_newline := '\r\n' // escape special characters like in C
	assert windows_newline.len == 2

	// arbitrary bytes can be directly specified using `\x##` notation where `#` is
	// a hex digit aardvark_str := '\x61ardvark' assert aardvark_str == 'aardvark'
	assert '\xc0'[0] == byte(0xc0)

	// or using octal escape `\###` notation where `#` is an octal digit
	aardvark_str2 := '\141ardvark'
	assert aardvark_str2 == 'aardvark'

	// Unicode can be specified directly as `\u####` where # is a hex digit
	// and will be converted internally to its UTF-8 representation
	star_str := '\u2605' // ★
	assert star_str == '★'
	assert star_str == '\xe2\x98\x85' // UTF-8 can be specified this way too.

	mut s := 'hello 🌎' // emoji takes 4 bytes
	// s[0] = 'H' // not allowed
	assert s.len == 10

	arr := s.bytes() // convert `string` to `[]byte`
	assert arr.len == 10

	s2 := arr.bytestr() // convert `[]byte` to `string`
	assert s2 == s

	s3 := r'hello\nworld' // the `\n` will be preserved as two characters
	println(s3) // "hello\nworld"

	s4 := '42'
	n := s4.int() // 42
	println(n)

	// all int literals are supported
	assert '0xc3'.int() == 195
	assert '0o10'.int() == 8
	assert '0b1111_0000_1010'.int() == 3850
	assert '-0b1111_0000_1010'.int() == -3850

	// String interpolation
	xx := 123.4567
	println('[${xx:.2}]') // round to two decimal places => [123.46]
	println('[${xx:10}]') // right-align with spaces on the left => [   123.457]
	println('[${int(xx):-10}]') // left-align with spaces on the right => [123       ]
	println('[${int(xx):010}]') // pad with zeros on the left => [0000000123]
	println('[${int(xx):b}]') // output as binary => [1111011]
	println('[${int(xx):o}]') // output as octal => [173]
	println('[${int(xx):X}]') // output as uppercase hex => [7B]

	println('[${10.0000:.2}]') // remove insignificant 0s at the end => [10]
	println('[${10.0000:.2f}]') // do show the 0s at the end, even though they do not change the number => [10.00]

	// String operators
	my_name := '中'
	my_country := my_name + '国' // + is used to concatenate strings
	println(my_country) // "中国"
	mut ciz := '中华'
	ciz += '民族' // `+=` is used to append to a string
	println(ciz) // "中华民族"
	my_age := 30
	// println('myAge = ' + my_age) // error: infix expr: cannot use `int` (right expression) as `string`
	println('myAge = ' + my_age.str())
	println('myAge = $my_age')

	println('===========================================================')

	// Runes
	strings := 'Netherlands'
	println(strings[0]) // Output: 78
	println(strings[0].ascii_str()) // Output: N

	rocket := `🚀`
	println(typeof(rocket).name) // rune
    // 使用 .str() 方法将 rune 转换为 UTF-8 字符串
	assert rocket.str() == '🚀'
    // 使用 .bytes() 方法将 rune 转换为 UTF-8 bytes
	assert rocket.bytes() == [byte(0xf0), 0x9f, 0x9a, 0x80]

	rocket_string := '🚀'
	println(typeof(rocket_string).name) // string
	assert rocket_string[0] != `🚀`
	assert 'aloha!'[0] == `a`

	hello := 'Hello World 👋'
	println(typeof(hello).name) // string
	hello_runes := hello.runes() // [`H`, `e`, `l`, `l`, `o`, ` `, `W`, `o`, `r`, `l`, `d`, ` `, `👋`]
	assert hello_runes.string() == hello

	country := '中国🌎★'.runes()
	println(typeof(country).name) // []rune
	println(country[0]) // Output: 中
	println(country[0..2]) // 输出：[`中`, `国`]
	for i := 0; i < country.len; i++ {
		println('rune: ${country[i]}')
	}
	for i, str in country {
		println("$i, rune=$str")
	}

	println('===========================================================')

	// 数组，其实是Slices
	mut nums := [1, 2, 3]
	println(nums) // [1, 2, 3]

	nums << 4
	println(nums) // [1, 2, 3, 4]

	nums << [5, 6, 7]
	println(nums) // [1, 2, 3, 4, 5, 6, 7]

	mut names := ['John']
	names << 'Peter'
	names << 'Sam'
	// names << 10  // error: cannot append `int literal` to `[]string`
	println(names)
	println('Alex' in names) // false
	println('是否存在：${'Alex' in names}') // false

	println('names.len = ${names.len}') // 3
	println('names.cap = ${names.cap}') // 3
	println('names.data = ${names.data}') // 类型为 voidptr，其中包含第一个元素的地址。这是针对底层不安全代码的
	println(typeof(names.data).name) // voidptr
	names = [] // The array is now empty
	println('names.len = ${names.len}') // 0
	println('names.data = ${names.data}') // 0

	// 用户可以显式指定第一个元素的类型：[byte(16), 32, 64, 128]

	// len 默认为 0，init为元素类型的默认初始化（数字类型为 0，字符串为 '' 
	// 运行时系统确保 cap 不小于 len（即使明确指定了较小的cap）
	mut my_arr := []int{len: 10, cap: 20, init: 3}
	println(my_arr)
	my_arr = []int{len: 5, init: -1} // my_arr.cap == 5
	println(my_arr)

	// 声明一个空数组：
	users := []int{}
	println(users)

	mut numbers := []int{cap: 1000}
	println('numbers.len = ${numbers.len}') // 0
	println('numbers.cap = ${numbers.cap}') // 1000
	// 现在追加元素不会重新分配 
	for i in 0 .. 1000 {
		numbers << i
	}
	println(29 in numbers)

	count := []int{len: 4, init: it}
	assert count == [0, 1, 2, 3]

	square := []int{len: 6, init: it * it}
	assert square == [0, 1, 4, 9, 16, 25]

	// Array methods
	my_arr = [1, 2, 3, 4, 5, 6]
	println(my_arr.str())
	even := my_arr.filter(it % 2 == 0)
	println(even) // [2, 4, 6]

	even_fn := nums.filter(fn (x int) bool {
		return x % 2 == 0
	})
	println(even_fn)

	words := ['hello', 'world']
	upper := words.map(it.to_upper())
	println(upper) // ['HELLO', 'WORLD']
	upper_fn := words.map(fn (w string) string {
		return w.to_upper()
	})
	println(upper_fn) // ['HELLO', 'WORLD']

	// 使用 .clone() 从数组中复制数据
	my_arr_copy := my_arr.clone()

	println(my_arr_copy.any(it == 2)) // true
	println(my_arr_copy.all(it >= 2)) // false

	// using filter, map and negatives array slices
	files := ['pippo.jpg', '01.bmp', '_v.txt', 'img_02.jpg', 'img_01.JPG']
	filtered := files.filter(it#[-4..].to_lower() == '.jpg').map(it.to_upper())
	println(filtered) // ['PIPPO.JPG', 'IMG_02.JPG', 'IMG_01.JPG']

	num_arr := [1, 2, 3]
	large_index := 999
	val_1 := num_arr[large_index] or { -1 }
	println(val_1)
	// 你也可以这样做，如果你想*传播*访问错误:
	// val_2 := num_arr[333] ?
	// println(val_2)

	println('===========================================================')

	// 固定长度的数组
	mut fnums := [3]int{} // fnums is a fixed size array with 3 elements.
	fnums[0] = 1
	fnums[1] = 10
	fnums[2] = 100
	println(fnums) // => [1, 10, 100]
	println(typeof(fnums).name) // => [3]int

	fnums2 := [1, 10, 100]! // short init syntax that does the same (the syntax will probably change)
	println(typeof(fnums2).name)

	anums := fnums[..] // same as `anums := fnums[0..fnums.len]`
	println(anums) // => [1, 10, 100]
	println(typeof(anums).name) // => []int

	println('===========================================================')

	// Map
	mut dict := map[string]int{} // a map with `string` keys and `int` values
	dict['one'] = 1
	dict['two'] = 2
	println(dict['one']) // 1
	println(dict['bad_key']) // 0
	println('bad_key' in dict) // Use `in` to detect whether such key exists
	keys := dict.keys()
	println(keys) // ['one', 'two']
	println(typeof(keys).name) // []string
	dict.delete('two')
	// `or` block must provide a default value of type `int`, or return/continue/break or call a [noreturn] function like panic(err) or exit(1)
	val := dict['bad_key'] or { -1 }
	println(val)

	// 使用简短的语法初始化map
	intm := {
		1: 1234
		2: 5678
	}
	println(intm)

	for key, value in intm {
		println('$key : $value')
	}

	for i in 0 .. 5 {
		print(i)
	}

	println('===========================================================')

	// In operator
	println(1 in intm) // true
	println(3 !in intm) // true

	parser := Parser{Token.plus}
	// V优化了这些表达式，因此下面两个if语句产生了相同的机器码，并且没有创建数组
	if parser.token == .plus 
		|| parser.token == .minus 
		|| parser.token == .div 
		|| parser.token == .mult {
		println('parser.token = ${parser.token}')
	}
	if parser.token in [.plus, .minus, .div, .mult] {
		println('parser.token = ${parser.token}')
	}

	println('===========================================================')

	// Statements & expressions

	println(if 100 % 2 == 0 { 'even' } else { 'odd' })

	println('===========================================================')

	// Module imports

	mytime := time.Time{
		year: 2020
		month: 12
		day: 25
	}
	println(mytime)

	println('--------------------------------')

	// Time.local() bug
	// https://github.com/vlang/v/issues/13828
	println(time.now())
	println(time.now().local())
	println(time.now().local().local())
	println(time.now().local().local().local())

	// read text from stdin
	username := os.input('Enter your username: ')
	println('Hello, $username!')

	user_os := os.user_os()
	println('Your OS is ${user_os}.')

	mut user := mymod.new_user(username, 111)
	println('typeof(user).name = ${typeof(user).name}') // &my_module.User
	println('user.is_registered() = ${user.is_registered()}') // false
	user.register()
	println('user.is_registered() = ${user.is_registered()}') // true
	// println(user.name) // error: field `my_module.User.name` is not public
	println('user.get_name() = ${user.get_name()}')
	println('user.d = ${user.d}')
	// user.d = 456 // error: field `d` of struct `my_module.User` is immutable
	println('user.e = ${user.e}')
	user.e = 123
	println('user.e = ${user.e}')

	println('===========================================================')

	// Heap structs

	// Structs are allocated on the stack. 
	// To allocate a struct on the heap and get a reference to it, use the & prefix:
	// 结构是在Stack上分配的。要在Heap上分配一个struct并获取它的引用，请使用&前缀:
	fa := Foo{1}
	println('typeof(fa).name = ${typeof(fa).name}') // Foo
	mut aaa := fa
	println('typeof(aaa).name = ${typeof(aaa).name}') // Foo
	aaa.x = 2
	assert fa.x == 1
	assert aaa.x == 2

	// fb := Foo{ 1 }
	// mut bbb := &fb  // error: `fb` is immutable, cannot have a mutable reference to it
	// bbb.x = 2

	fbb := &Foo{1}
	println('typeof(fbb).name = ${typeof(fbb).name}') // &Foo

	mut fc := Foo{1}
	mut ccc := &fc
	ccc.x = 2
	assert fc.x == 2
	assert ccc.x == 2
	println(fc) // Foo{ x: 2 }
	println(ccc) // &Foo{ x: 2 } // 注意 `&` 前缀

	mut inum := 1010
	mut ref := &inum
	println(ref)  // &1010
	println(*ref) // 1010

	println('===========================================================')

	// 闭包（Closures）
	// my_int := 1
	// my_closure := fn [my_int] (n int) int {
	// 	return my_int + n
	// }
	// println(my_closure(2))

	println('===========================================================')

	println('os.quoted_path(@VEXE) = ${os.quoted_path(@VEXE)}')

}

fn add(x int, y int) int {
	return x + y
}

fn sub(x int, y int) int {
	return x - y
}

fn foo(x int, y int) (int, int)  {
	return x + y, x - y
}

pub fn public_function() string {
	return 'this is public_function'
}

enum Token {
	plus
	minus
	div
	mult
}

struct Parser {
	token Token
}

struct Foo {
mut:
	x int
}
