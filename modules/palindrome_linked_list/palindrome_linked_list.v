
// https://leetcode-cn.com/problems/palindrome-linked-list/
// 回文链表

[heap]
struct ListNode  {
	val  int
mut:
	next &ListNode
}

fn is_palindrome_linked_list(head &ListNode) bool {
	mut list := []int{}

	for p := head; p != 0; p = p.next {
		list << p.val
	}

	println('list = ${list}')

	len := list.len

	for i, j := 0, len - 1; i < j; i++, j-- {
		if list[i] != list[j] {
			return false
		}
	}

	return true
}

fn main() {
	head := &ListNode{val : 1, next: 0}
	mut p := head

	for i in 2 .. 5 {
		p.next = &ListNode{val : i, next : 0}
		p = p.next
	}

	for i := 4; i >= 1; i-- {
		p.next = &ListNode{val : i, next : 0}
		p = p.next
	}

	println(is_palindrome_linked_list(head))

	unsafe {
		free(head)
	}
}
