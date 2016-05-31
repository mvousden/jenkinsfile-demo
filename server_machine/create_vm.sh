#!/bin/bash

function echo_create_vm {
    echo "[create_vm] $1"
}

function get_machine_status {
    STATUS=$(vagrant status --machine-readable | grep ",state," | cut -d, -f4)
}

# Get the status of the machine.
get_machine_status
MACHINE_NAME=jenkinsfile-demo

# Only run if the machine doesn't exist.
if [ "$STATUS" == "not_created" ]; then

    # Substitute name in vagrantfile.
    sed "s|MACHINE_NAME|$MACHINE_NAME|" -i Vagrantfile

    # Create machine
    echo_create_vm "Creating machine..."
    vagrant up --no-provision
    echo_create_vm "Provisioning machine..."
    vagrant provision  # Installs Jenkins

    # Change the network interface. To do this, we must turn off the machine,
    # disable the NIC, and start the machine up again using VirtualBox.
    vagrant halt

    echo "Waiting for virtual machine to shut down..."
    get_machine_status
    while [ "$STATUS" != "poweroff" ]; do
        echo_create_vm "Current machine status is: $STATUS"
        sleep 5
        get_machine_status
    done
    echo_create_vm "Machine turned off successfully."

    echo_create_vm "Changing network interfaces..."
    VBoxManage modifyvm $MACHINE_NAME --nic1 none

    echo_create_vm "Starting machine again..."
    VBoxManage startvm $MACHINE_NAME --type headless

    # Now wait for machine to boot.
    get_machine_status
    while [ "$STATUS" != "running" ]; do
        echo_create_vm "Waiting for machine to boot. Current status is:
$STATUS"
        sleep 15
        get_machine_status
    done

    # Finish!
    echo_create_vm "Your machine has booted and provisioned successfully. Check
$MACHINE_NAME.ngcm.soton.ac.uk:8080 for your shiny new Jenkins server."

else
    echo_create_vm "The machine exists, so I'm not rebuilding it.
fi

