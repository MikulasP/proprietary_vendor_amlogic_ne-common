#!/bash/sh

if [ $# -eq 0 ]
then
	echo "Pls input at least one parameter"
	exit 0
fi

echo "Addr: $1"

addr_len=$(echo $1 | awk '{print length($1)}')
data_len=$(echo $2 | awk '{print length($1)}')

#echo "Addr and Data lenth:$addr_len $data_len"

if [ $addr_len -eq 10 ]
then
	#echo "addr ok"
	echo ""
else
	echo "Addr lenth Error !!!"
	echo "Pls renew input 8 Byte addr (eg:0x11223344)"
	exit 0
fi


if [ $# -eq 2 ]
then
	if [ $data_len -eq 10 ]
	then
		echo "Data: $2"
		#echo "data ok"	
		echo " "
	else
		echo "Data lenth Error !!!"
		echo "Pls renew input 8 Byte data (eg:0x11223344)"
		exit 0
	fi
fi

addr_str=$1
data_str=$2

A0=0x${addr_str:2:2}
A1=0x${addr_str:4:2}
A2=0x${addr_str:6:2}
A3=0x${addr_str:8:2}

#echo "A0:$A0 A1:$A1 A2:$A2 A3:$A3"

D0=0x${data_str:2:2}
D1=0x${data_str:4:2}
D2=0x${data_str:6:2}
D3=0x${data_str:8:2}

#echo "D0:$D0 D1:$D1 D2:$D2 D3:$D3"


if [ $# -eq 1 ]
then
	echo read
	echo "iw dev wlan0 vendor send 0xc3 0xc4 0x09 $A0 $A1 $A2 $A3"
	iw dev wlan0 vendor send 0xc3 0xc4 0x09 $A0 $A1 $A2 $A3
fi

if [ $# -eq 2 ]
then
	echo write
	echo "iw dev wlan0 vendor send 0xc3 0xc4 0x0a $A0 $A1 $A2 $A3 $D0 $D1 $D2 $D3"
	iw dev wlan0 vendor send 0xc3 0xc4 0x0a $A0 $A1 $A2 $A3 $D0 $D1 $D2 $D3
fi

