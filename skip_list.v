// module skip_list

// 跳表最大层数
const max_level = 32

struct SkipList<T> {
	head &Node<T> // 头节点
	highLevel int // 当前跳表索引层数
	random Random
}

pub fn new_skip_list() &SkipList {
	return &SkipList{
		head : &Node{value : 123456789}
		highLevel : 0
		random : &Random{}
	}
}

struct Node<T> {
	key int
	value T
	right &Node<T>
	down &Node<T>
}

