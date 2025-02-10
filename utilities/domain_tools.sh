#!/bin/bash

# Default nameserver 
NAMESERVER="8.8.8.8"
RED='\033[0;31m'   # RED
NC='\033[0m'       # No Color

validate_domain() {
    local domain_regex="^([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$"
    if [[ ! $1 =~ $domain_regex ]]; then
        echo "Invalid domain name: $1"
        exit 1
    fi
}

validate_ip() {
    local ip_regex="^([0-9]{1,3}\.){3}[0-9]{1,3}$"
    if [[ ! $1 =~ $ip_regex ]]; then
        echo "Invalid IPv4 address: $1"
        exit 1
    fi
}

dns_lookup() {
    local domain=$1
    echo "===== DNS Lookup for $domain using Nameserver $NAMESERVER ====="
    echo -e "${RED}A Record${NC}: $(dig @$NAMESERVER +short A $domain)"
    echo -e "${RED}AAAA Record${NC}: $(dig @$NAMESERVER +short AAAA $domain)"
    echo -e "${RED}MX Record${NC}: $(dig @$NAMESERVER +short MX $domain)"
    echo -e "${RED}CNAME Record${NC}: $(dig @$NAMESERVER +short CNAME $domain)"
    echo -e "${RED}TXT Record${NC}: $(dig @$NAMESERVER +short TXT $domain)"
    echo -e "${RED}NS Record${NC}: $(dig @$NAMESERVER +short NS $domain)"
    echo -e "${RED}SOA Record${NC}: $(dig @$NAMESERVER +short SOA $domain)"
    echo "--------------------------------------"
}

# PTR (reverse DNS) lookup for IP
ptr_lookup() {
    local ip=$1
    echo "===== PTR Lookup for $ip using Nameserver $NAMESERVER ====="
    echo "PTR Record: $(dig @$NAMESERVER +short -x $ip)"
    echo "--------------------------------------"
}

# Read file with domains/IPs
process_file() {
    local file=$1
    if [[ ! -f "$file" ]]; then
        echo "Error: File $file not found!"
        exit 1
    fi

    while IFS= read -r line; do
        if [[ $line =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
            ptr_lookup "$line"
        elif [[ $line =~ ^([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$ ]]; then
            dns_lookup "$line"
        else
            echo "Skipping invalid entry: $line"
        fi
    done < "$file"
}

# Check if parameters provided
if [[ $# -eq 0 ]]; then
    echo "Usage: $0 [-d domain] [-i IP] [-f file] [-n nameserver]"
    echo "Options:"
    echo "  -d <domain>     : Perform DNS lookup for the specified domain"
    echo "  -i <IP>         : Perform PTR (reverse DNS) lookup for the specified IPv4 address"
    echo "  -f <file>       : Read domains and IPs from a file and perform appropriate lookups"
    echo "  -n <nameserver> : Specify a custom nameserver for DNS resolution (default: 8.8.8.8)"
    exit 1
fi

# Process DNS queries
while getopts "d:i:f:n:" opt; do
    case "$opt" in
        d) 
            validate_domain "$OPTARG"
            dns_lookup "$OPTARG"
            ;;
        i) 
            validate_ip "$OPTARG"
            ptr_lookup "$OPTARG"
            ;;
        f)
            process_file "$OPTARG"
            ;;
        *)
            echo "Invalid option. Use -d for domain, -i for IP, -f for file, and -n for nameserver."
            exit 1
            ;;
    esac
done

