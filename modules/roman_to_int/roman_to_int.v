
// https://leetcode-cn.com/problems/roman-to-integer/
// 罗马数字转整数
fn main() {
	roman_num_strs := ['V', 'II', 'III', 'IV', 'IX', 'LVIII', 'MCMXCIV']

	for str in roman_num_strs {
		number := roman_to_int(str)
		println(number)
	}
}

fn roman_to_int(str string) int {
	if str.len == 0 {
		return 0
	}

	mut sum := 0

	// str[0] 是 byte
	mut pre_num := get_number(str[0].ascii_str())

	for i := 1; i < str.len; i++ {
		num := get_number(str[i].ascii_str())

		if pre_num < num {
			sum -= pre_num
		} else {
			sum += pre_num
		}

		pre_num = num
	}

	// 最后一位永远为正数
	sum += pre_num

	return sum
}

fn get_number(s string) int {
	num := match s {
		'I' { 1 }
        'V' { 5 }
        'X' { 10 }
        'L' { 50 }
        'C' { 100 }
        'D' { 500 }
        'M' { 1000 }
        else { 0 } 
	}

	return num
}