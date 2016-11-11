//open util/boolean

/*sig Time{}
sig Location {
	lat : Int,
	lng : Int
}*/

sig Vehicle {}

sig Email {}

sig License {}

sig PaymentInfo{}

sig Driver {
	email : Email
}

sig Payment {
	amount  : Int,
	driver : one ValidDriver
}

sig ValidDriver extends Driver {
	license : one License,
	paymentinfo : one PaymentInfo
}

sig Reservation {
	driver : one ValidDriver,
	vehicle : one Vehicle
}

abstract sig ServiceEnd {
	reservation : one Reservation,
	payment : Payment
}

sig Usage extends ServiceEnd {
}

sig UsageWithReport extends Usage{
	report : Report
}

sig Fee extends ServiceEnd {
}

fact reservationUnique {
	all e1, e2 : ServiceEnd | e1 != e2 => e1.reservation != e2.reservation
}

fact uniqueDriverInfos {
	all d1,d2: Driver | d1 != d2 => d1.email != d2.email
	all d1,d2: ValidDriver | d1 != d2 => d1.license != d2.license
	all d1,d2: ValidDriver | d1 != d2 => d1.paymentinfo != d2.paymentinfo
}

fact singleReservation {
	all r1, r2: Reservation | r1 != r2 => r1.driver != r2.driver
	all r1, r2: Reservation | r1 != r2 => r1.vehicle != r2.vehicle
}

fact {
	ServiceEnd.payment  = Payment
	all se1, se2 : ServiceEnd | se1 != se2 => se1.payment != se2.payment
}

//Workers signals
sig Worker {
}

sig Report {
	vehicle : one Vehicle,
	code : Int
}

sig Task extends Report{
	worker : Worker
}


pred show() {
	#Vehicle = 3
	#UsageWithReport = 1
	#Usage = 2
	#Fee = 1
	#Task = 1
}

run show for 5
