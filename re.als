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

/*sig Payment {
	driver : one ValidDriver
}*/

sig ValidDriver extends Driver {
	license : one License,
	paymentinfo : one PaymentInfo
}

sig Reservation {
	driver : one ValidDriver,
	vehicle : one Vehicle
}

/*abstract sig ServiceEnd {
	driver : one ValidDriver,
	vehicle : one Vehicle,
	payment : Payment
}

sig Usage extends ServiceEnd {
}*/

/*sig UsageWithReport extends Usage{
	report : Report
}*/

/*sig Fee extends ServiceEnd {
}*/

fact uniqueDriverInfos {
	all d1,d2: Driver | d1 != d2 => d1.email != d2.email
	all d1,d2: ValidDriver | d1 != d2 => d1.license != d2.license
	all d1,d2: ValidDriver | d1 != d2 => d1.paymentinfo != d2.paymentinfo
	ValidDriver.license = License
	ValidDriver.paymentinfo = PaymentInfo
	ValidDriver.email = Email
}

fact singleReservation {
	all r1, r2: Reservation | r1 != r2 => r1.driver != r2.driver
	all r1, r2: Reservation | r1 != r2 => r1.vehicle != r2.vehicle
}

/*fact serviceends{
	ServiceEnd.payment  = Payment
	all se1, se2 : ServiceEnd | se1 != se2 => se1.payment != se2.payment
	all se : ServiceEnd | se.driver = se.payment.driver
}*/

fact mainteinance {
	all r : Reservation | not (r.vehicle in Report.vehicle)
	//all ur : UsageWithReport | ur.report.vehicle = ur.vehicle
	all t1, t2 : Report | t1 != t2 => t1.vehicle != t2.vehicle
}

//Workers signals
sig Worker {
}

sig Report {
	vehicle : one Vehicle,
	driver : one ValidDriver
}

sig Task extends Report{
	worker : Worker
}


pred show() {
	#Vehicle = 5
	#ValidDriver = 3
	#Reservation = 2
	//#Usage = 1
	//#Fee = 1
	//#UsageWithReport = 1
	#Report = 3
	#Worker = 2
}

run show for 5
