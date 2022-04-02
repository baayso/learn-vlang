// https://leetcode-cn.com/problems/ransom-note/
// 赎金信
// 给你两个字符串：ransom_note 和 magazine ，判断 ransom_note 能不能由 magazine 里面的字符构成。
// 如果可以，返回 true ；否则返回 false 。
// magazine 中的每个字符只能在 ransom_note 中使用一次。

fn can_construct(ransom_note string, magazine string) bool {
	if ransom_note.len > magazine.len {
		return false
	}

	mut hash_array := [26]int{}

	offset := 'a'[0]

	for ch in ransom_note {
		hash_array[ch - offset]++
	}

	for ch in magazine {
		hash_array[ch - offset]--
	}

	for item in hash_array {
		if item > 0 {
			return false
		}
	}

	return true
}

fn main() {
	println(can_construct('a', 'b'))         // false
	println(can_construct('aa', 'ab'))       // false
	println(can_construct('aa', 'aab'))      // true
	println(can_construct('aabb', 'aab'))    // false
	println(can_construct('aabbc', 'aacbb')) // true
}
