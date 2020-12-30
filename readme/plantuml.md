@startuml
skinparam rectangle {
	backgroundColor<<standalone>> lightcyan
}
rectangle ashely-rg <<RG>> as lafiterg {

    rectangle core <<vnet: 10.116.0.0/17>> {

        rectangle node <<subnet: 10.116.2.0/24>> {

            rectangle cassandra <<vm: 10.116.2.4>><<standalone>> as cv1
            rectangle cassandra <<vm: 10.116.2.5>><<standalone>> as cv2
            rectangle cassandra <<vm: 10.116.2.6>><<standalone>> as cv3

            rectangle calbip <<privateip>> [
                cassandralb
                10.116.2.7
            ]
            rectangle cassandralb <<loadbalancer>> [
                7000 -> 7000
                9042 -> 9042
            ]
            calbip --> cassandralb
        }

    }

    cassandralb --> cv1
    cassandralb --> cv2
    cassandralb --> cv3

    rectangle develop <<vnet: 10.116.128.0/17>> {
        rectangle <<subnet: 10.116.128.0/24>> {
            rectangle bastion <<vm>> as bastion
        }
    }

    rectangle external <<vnet: 10.115.0.0/17>> {
        rectangle <<subnet: 10.115.0.0/24>> {
            rectangle bastion <<vm>> as bastion
        }
    }
}

@enduml