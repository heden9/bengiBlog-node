function FindKthToTail(head, k)
{
    // write code here
    k --;
    var head2;
    var currentHead = head;
    if (k===0 && !head.next){
        return head;
    }
    var i = 0;
    while(head){
        if(i === k){
            head2 = currentHead;
        }else if (head2){
            head2 = head2.next;
        }
        head = head.next;
        i++;
    }
    return head2;
}

var head = {

	val: 1,
	next: {
		val: 2,
		next: {
			val: 3,
			 next: {
                 val: 4,
                 next: null
             }
		}
	}
}
var head2 = {

	val: 1.5,
	next: {
		val: 3,
		next: {
			val: 3.5,
			 next: {
                 val: 6,
                 next: null
             }
		}
	}
}
// FindKthToTail(head, 4)

function Merge(pHead1, pHead2)
{
    // write code here
    if (pHead1 === null){
        return pHead2;
    }
    if (pHead2 === null){
        return pHead1;
    }
    if(pHead1.val < pHead2.val){
        pHead1.next = Merge(pHead1.next, pHead2);
        return pHead1;
    }else {
        pHead2.next = Merge(pHead1, pHead2.next);
        return pHead2;
    }
}
var s = Merge(head, head2);
