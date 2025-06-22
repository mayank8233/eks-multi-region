#!/bin/bash
echo "1) Deploy VPC"
echo "2) Deploy EKS"
read -p "Choose an option [1-2]: " opt

case $opt in
  1) ./run-vpc.sh ;;
  2) ./run-eks.sh ;;
  *) echo "Invalid option." ;;
esac