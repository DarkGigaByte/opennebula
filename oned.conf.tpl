#*******************************************************************************
#                       OpenNebula Configuration file
#*******************************************************************************

#*******************************************************************************
# Daemon configuration attributes
#-------------------------------------------------------------------------------
#  MANAGER_TIMER: Time in seconds the core uses to evaluate periodical functions.
#  MONITORING_INTERVAL cannot have a smaller value than MANAGER_TIMER.
#
#  MONITORING_INTERVAL: Time in seconds between host and VM monitorization.
#
#  MONITORING_THREADS: Max. number of threads used to process monitor messages
#
#  HOST_PER_INTERVAL: Number of hosts monitored in each interval.
#  HOST_MONITORING_EXPIRATION_TIME: Time, in seconds, to expire monitoring
#  information. Use 0 to disable HOST monitoring recording.
#
#  VM_INDIVIDUAL_MONITORING: VM monitoring information is obtained along with the
#  host information. For some custom monitor drivers you may need activate the
#  individual VM monitoring process.
#  VM_PER_INTERVAL: Number of VMs monitored in each interval, if the individual
#  VM monitoring is set to yes.
#  VM_MONITORING_EXPIRATION_TIME: Time, in seconds, to expire monitoring
#  information. Use 0 to disable VM monitoring recording.
#
#  SCRIPTS_REMOTE_DIR: Remote path to store the monitoring and VM management
#  scripts.
#
#  PORT: Port where oned will listen for xmlrpc calls.
#  LISTEN_ADDRESS: Host IP to listen on for xmlrpc calls (default: all IPs).
#
#  DB: Configuration attributes for the database backend
#   backend : can be sqlite or mysql (default is sqlite)
#   server  : (mysql) host name or an IP address for the MySQL server
#   port    : (mysql) port for the connection to the server.
#                     If set to 0, the default port is used.
#   user    : (mysql) user's MySQL login ID
#   passwd  : (mysql) the password for user
#   db_name : (mysql) the database name
#
#  VNC_PORTS: VNC port pool for automatic VNC port assignment, if possible the
#  port will be set to ``START`` + ``VMID``
#   start   : first port to assign
#   reserved: comma separated list of ports or ranges. Two numbers separated by
#   a colon indicate a range.
#
#  LOG: Configuration for the logging system
#   system: defines the logging system:
#      file      to log in the oned.log file
#      syslog    to use the syslog facilities
#      std       to use the default log stream (stderr) to use with systemd
#   debug_level: 0 = ERROR, 1 = WARNING, 2 = INFO, 3 = DEBUG
#
#  VM_SUBMIT_ON_HOLD: Forces VMs to be created on hold state instead of pending.
#  Values: YES or NO.
#*******************************************************************************

LOG = [
  SYSTEM      = "file",
  DEBUG_LEVEL = 3
]

#MANAGER_TIMER = 15

MONITORING_INTERVAL = 60
MONITORING_THREADS  = 50

#HOST_PER_INTERVAL               = 15
#HOST_MONITORING_EXPIRATION_TIME = 43200

#VM_INDIVIDUAL_MONITORING      = "no"
#VM_PER_INTERVAL               = 5
#VM_MONITORING_EXPIRATION_TIME = 14400

SCRIPTS_REMOTE_DIR=/var/tmp/one

PORT = 2633

LISTEN_ADDRESS = "0.0.0.0"

#DB = [ BACKEND = "sqlite" ]

# Sample configuration for MySQL
DB = [ BACKEND = "mysql",
       SERVER  = "{{ MYSQL_HOST }}",
       PORT    = {{ MYSQL_PORT|default(3306) }},
       USER    = "{{ MYSQL_USER }}",
       PASSWD  = "{{ MYSQL_PASSWORD }}",
       DB_NAME = "{{ MYSQL_DATABASE }}" ]

VNC_PORTS = [
    START    = 5900
#    RESERVED = "6800, 6801, 6810:6820, 9869"
]

#VM_SUBMIT_ON_HOLD = "NO"

#*******************************************************************************
# Federation configuration attributes
#-------------------------------------------------------------------------------
# Control the federation capabilities of oned. Operation in a federated setup
# requires a special DB configuration.
#
#  FEDERATION: Federation attributes
#   MODE: Operation mode of this oned.
#       STANDALONE no federated.This is the default operational mode
#       MASTER     this oned is the master zone of the federation
#       SLAVE      this oned is a slave zone
#   ZONE_ID: The zone ID as returned by onezone command
#   MASTER_ONED: The xml-rpc endpoint of the master oned, e.g.
#   http://master.one.org:2633/RPC2
#*******************************************************************************

FEDERATION = [
    MODE        = "STANDALONE",
    ZONE_ID     = 0,
    MASTER_ONED = ""
]

#*******************************************************************************
# Default showback cost
#-------------------------------------------------------------------------------
# The following attributes define the default cost for Virtual Machines that
# don't have a CPU, MEMORY or DISK cost. This is used by the oneshowback
# calculate method.
#*******************************************************************************

DEFAULT_COST = [
    CPU_COST    = 0,
    MEMORY_COST = 0,
    DISK_COST   = 0
]

#*******************************************************************************
# XML-RPC server configuration
#-------------------------------------------------------------------------------
#  These are configuration parameters for oned's xmlrpc-c server
#
#  MAX_CONN: Maximum number of simultaneous TCP connections the server
#  will maintain
#
#  MAX_CONN_BACKLOG: Maximum number of TCP connections the operating system
#  will accept on the server's behalf without the server accepting them from
#  the operating system
#
#  KEEPALIVE_TIMEOUT: Maximum time in seconds that the server allows a
#  connection to be open between RPCs
#
#  KEEPALIVE_MAX_CONN: Maximum number of RPCs that the server will execute on
#  a single connection
#
#  TIMEOUT: Maximum time in seconds the server will wait for the client to
#  do anything while processing an RPC. This timeout will be also used when
#  proxy calls to the master in a federation.
#
#  RPC_LOG: Create a separated log file for xml-rpc requests, in
#  "/var/log/one/one_xmlrpc.log".
#
#  MESSAGE_SIZE: Buffer size in bytes for XML-RPC responses.
#
#  LOG_CALL_FORMAT: Format string to log XML-RPC calls. Interpreted strings:
#     %i -- request id
#     %m -- method name
#     %u -- user id
#     %U -- user name
#     %l -- param list
#     %p -- user password
#     %g -- group id
#     %G -- group name
#     %a -- auth token
#     %% -- %
#*******************************************************************************

#MAX_CONN           = 15
#MAX_CONN_BACKLOG   = 15
#KEEPALIVE_TIMEOUT  = 15
#KEEPALIVE_MAX_CONN = 30
#TIMEOUT            = 15
#RPC_LOG            = NO
#MESSAGE_SIZE       = 1073741824
#LOG_CALL_FORMAT    = "Req:%i UID:%u %m invoked %l"

#*******************************************************************************
# Physical Networks configuration
#*******************************************************************************
#  NETWORK_SIZE: Here you can define the default size for the virtual networks
#
#  MAC_PREFIX: Default MAC prefix to be used to create the auto-generated MAC
#  addresses is defined here (this can be overwritten by the Virtual Network
#  template)
#
#  VLAN_IDS: VLAN ID pool for the automatic VLAN_ID assignment. This pool
#  is for 802.1Q networks (Open vSwitch and 802.1Q drivers). The driver
#  will try first to allocate VLAN_IDS[START] + VNET_ID
#     start: First VLAN_ID to use
#     reserved: Comma separated list of VLAN_IDs or ranges. Two numbers
#     separated by a colon indicate a range.
#
# VXLAN_IDS: Automatic VXLAN Network ID (VNI) assignment. This is used
# for vxlan networks.
#     start: First VNI to use
#     NOTE: reserved is not supported by this pool
#
# PCI_PASSTHROUGH_BUS: Default bus to attach passthrough devices in the guest,
# in hex notation. It may be overwritten in the PCI device using the BUS
# attribute.
#*******************************************************************************

NETWORK_SIZE = 254

MAC_PREFIX   = "02:00"

VLAN_IDS = [
    START    = "2",
    RESERVED = "0, 1, 4095"
]

VXLAN_IDS = [
    START = "2"
]

#PCI_PASSTHROUGH_BUS = "0x01"

#*******************************************************************************
# DataStore Configuration
#*******************************************************************************
#  DATASTORE_LOCATION: Path for Datastores. It IS the same for all the hosts
#  and front-end. It defaults to /var/lib/one/datastores (in self-contained mode
#  defaults to $ONE_LOCATION/var/datastores). Each datastore has its own
#  directory (called BASE_PATH) in the form: $DATASTORE_LOCATION/<datastore_id>
#  You can symlink this directory to any other path if needed. BASE_PATH is
#  generated from this attribute each time oned is started.
#
#  DATASTORE_CAPACITY_CHECK: Checks that there is enough capacity before
#  creating a new image. Defaults to Yes
#
#  DEFAULT_IMAGE_TYPE: This can take values
#       OS        Image file holding an operating system
#       CDROM     Image file holding a CDROM
#       DATABLOCK Image file holding a datablock, created as an empty block
#
#  DEFAULT_DEVICE_PREFIX: This can be set to
#       hd        IDE prefix
#       sd        SCSI
#       vd        KVM virtual disk
#
#  DEFAULT_CDROM_DEVICE_PREFIX: Same as above but for CDROM devices.
#*******************************************************************************

#DATASTORE_LOCATION  = /var/lib/one/datastores

DATASTORE_CAPACITY_CHECK = "yes"

DEFAULT_IMAGE_TYPE    = "OS"
DEFAULT_DEVICE_PREFIX = "hd"

DEFAULT_CDROM_DEVICE_PREFIX = "hd"

#*******************************************************************************
# Information Driver Configuration
#*******************************************************************************
# You can add more information managers with different configurations but make
# sure it has different names.
#
#   name      : name for this information manager
#
#   executable: path of the information driver executable, can be an
#               absolute path or relative to $ONE_LOCATION/lib/mads (or
#               /usr/lib/one/mads/ if OpenNebula was installed in /)
#
#   arguments : for the driver executable, usually a probe configuration file,
#               can be an absolute path or relative to $ONE_LOCATION/etc (or
#               /etc/one/ if OpenNebula was installed in /)
#*******************************************************************************

#-------------------------------------------------------------------------------
#  Information Collector for KVM IM's.
#-------------------------------------------------------------------------------
#  This driver CANNOT BE ASSIGNED TO A HOST, and needs to be used with KVM
#    -h  prints this help.
#    -a  Address to bind the collectd socket (default 0.0.0.0)
#    -p  UDP port to listen for monitor information (default 4124)
#    -f  Interval in seconds to flush collected information (default 5)
#    -t  Number of threads for the server (default 50)
#    -i  Time in seconds of the monitorization push cycle. This parameter must
#        be smaller than MONITORING_INTERVAL, otherwise push monitorization will
#        not be effective.
#    -w  Timeout in seconds to execute external commands (default unlimited)
#-------------------------------------------------------------------------------
IM_MAD = [
      NAME       = "collectd",
      EXECUTABLE = "collectd",
      ARGUMENTS  = "-p 4124 -f 5 -t 50 -i 20" ]
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  KVM UDP-push Information Driver Manager Configuration
#    -r number of retries when monitoring a host
#    -t number of threads, i.e. number of hosts monitored at the same time
#    -w Timeout in seconds to execute external commands (default unlimited)
#-------------------------------------------------------------------------------
IM_MAD = [
      NAME          = "kvm",
      SUNSTONE_NAME = "KVM",
      EXECUTABLE    = "one_im_ssh",
      ARGUMENTS     = "-r 3 -t 15 kvm" ]
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  KVM SSH-pull Information Driver Manager Configuration
#    -r number of retries when monitoring a host
#    -t number of threads, i.e. number of hosts monitored at the same time
#    -w Timeout in seconds to execute external commands (default unlimited)
#-------------------------------------------------------------------------------
# IM_MAD = [
#       NAME          = "kvm",
#       SUNSTONE_NAME = "kvm-ssh",
#       EXECUTABLE    = "one_im_ssh",
#       ARGUMENTS     = "-r 3 -t 15 kvm-probes" ]
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  vCenter Information Driver Manager Configuration
#    -r number of retries when monitoring a host
#    -t number of threads, i.e. number of hosts monitored at the same time
#    -w Timeout in seconds to execute external commands (default unlimited)
#-------------------------------------------------------------------------------
#IM_MAD = [
#      NAME          = "vcenter",
#      SUNSTONE_NAME = "VMWare vCenter",
#      EXECUTABLE    = "one_im_sh",
#      ARGUMENTS     = "-c -t 15 -r 0 vcenter" ]
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  EC2 Information Driver Manager Configuration
#    -r number of retries when monitoring a host
#    -t number of threads, i.e. number of hosts monitored at the same time
#    -w Timeout in seconds to execute external commands (default unlimited)
#-------------------------------------------------------------------------------
#IM_MAD = [
#      NAME          = "ec2",
#      SUNSTONE_NAME = "Amazon EC2",
#      EXECUTABLE    = "one_im_sh",
#      ARGUMENTS     = "-c -t 1 -r 0 -w 600 ec2" ]
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  Azure Information Driver Manager Configuration
#    -r number of retries when monitoring a host
#    -t number of threads, i.e. number of hosts monitored at the same time
#    -w Timeout in seconds to execute external commands (default unlimited)
#-------------------------------------------------------------------------------
#IM_MAD = [
#      NAME          = "az",
#      SUNSTONE_NAME = "Microsoft Azure",
#      EXECUTABLE    = "one_im_sh",
#      ARGUMENTS     = "-c -t 1 -r 0 az" ]
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  Dummy Information Driver Manager Configuration
#-------------------------------------------------------------------------------
#IM_MAD = [ NAME="dummy", SUNSTONE_NAME="Testing", EXECUTABLE="one_im_dummy"]
#-------------------------------------------------------------------------------

#*******************************************************************************
# Virtualization Driver Configuration
#*******************************************************************************
# You can add more virtualization managers with different configurations but
# make sure it has different names.
#
#   name      : name of the virtual machine manager driver
#
#   executable: path of the virtualization driver executable, can be an
#               absolute path or relative to $ONE_LOCATION/lib/mads (or
#               /usr/lib/one/mads/ if OpenNebula was installed in /)
#
#   arguments : for the driver executable
#
#   default   : default values and configuration parameters for the driver, can
#               be an absolute path or relative to $ONE_LOCATION/etc (or
#               /etc/one/ if OpenNebula was installed in /)
#
#   type      : driver type, supported drivers: xen, kvm, xml
#
#   keep_snapshots: do not remove snapshots on power on/off cycles and live
#   migrations if the hypervisor supports that.
#
#   imported_vms_actions : comma-separated list of actions supported
#                          for imported vms. The available actions are:
#                              migrate
#                              live-migrate
#                              terminate
#                              terminate-hard
#                              undeploy
#                              undeploy-hard
#                              hold
#                              release
#                              stop
#                              suspend
#                              resume
#                              delete
#                              delete-recreate
#                              reboot
#                              reboot-hard
#                              resched
#                              unresched
#                              poweroff
#                              poweroff-hard
#                              disk-attach
#                              disk-detach
#                              nic-attach
#                              nic-detach
#                              snap-create
#                              snap-delete
#*******************************************************************************

#-------------------------------------------------------------------------------
#  KVM Virtualization Driver Manager Configuration
#    -r number of retries when monitoring a host
#    -t number of threads, i.e. number of hosts monitored at the same time
#    -l <actions[=command_name]> actions executed locally, command can be
#        overridden for each action.
#        Valid actions: deploy, shutdown, cancel, save, restore, migrate, poll
#        An example: "-l migrate=migrate_local,save"
#    -p more than one action per host in parallel, needs support from hypervisor
#    -s <shell> to execute remote commands, bash by default
#    -w Timeout in seconds to execute external commands (default unlimited)
#
#  Note: You can use type = "qemu" to use qemu emulated guests, e.g. if your
#  CPU does not have virtualization extensions or use nested Qemu-KVM hosts
#-------------------------------------------------------------------------------
VM_MAD = [
    NAME           = "kvm",
    SUNSTONE_NAME  = "KVM",
    EXECUTABLE     = "one_vmm_exec",
    ARGUMENTS      = "-t 15 -r 0 kvm",
    DEFAULT        = "vmm_exec/vmm_exec_kvm.conf",
    TYPE           = "kvm",
    KEEP_SNAPSHOTS = "no",
    IMPORTED_VMS_ACTIONS = "terminate, terminate-hard, hold, release, suspend,
        resume, delete, reboot, reboot-hard, resched, unresched, disk-attach,
        disk-detach, nic-attach, nic-detach, snap-create, snap-delete"
]

#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  vCenter Virtualization Driver Manager Configuration
#    -r number of retries when monitoring a host
#    -t number of threads, i.e. number of hosts monitored at the same time
#    -p more than one action per host in parallel, needs support from hypervisor
#    -s <shell> to execute commands, bash by default
#    -d default snapshot strategy. It can be either 'detach' or 'suspend'. It
#       defaults to 'suspend'.
#    -w Timeout in seconds to execute external commands (default unlimited)
#-------------------------------------------------------------------------------
#VM_MAD = [
#    NAME           = "vcenter",
#    SUNSTONE_NAME  = "VMWare vCenter",
#    EXECUTABLE     = "one_vmm_sh",
#    ARGUMENTS      = "-p -t 15 -r 0 vcenter -s sh",
#    DEFAULT        = "vmm_exec/vmm_exec_vcenter.conf",
#    TYPE           = "xml",
#    KEEP_SNAPSHOTS = "yes",
#    IMPORTED_VMS_ACTIONS = "terminate, terminate-hard, hold, release, suspend,
#        resume, delete, reboot, reboot-hard, resched, unresched, poweroff,
#        poweroff-hard, disk-attach, disk-detach, nic-attach, nic-detach,
#        snap-create, snap-delete"
#]
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  EC2 Virtualization Driver Manager Configuration
#    -r number of retries when monitoring a host
#    -t number of threads, i.e. number of actions performed at the same time
#    -w Timeout in seconds to execute external commands (default unlimited)
#    -p more than one action per host in parallel, needs support from hypervisor
#-------------------------------------------------------------------------------
#VM_MAD = [
#    NAME           = "ec2",
#    SUNSTONE_NAME  = "Amazon EC2",
#    EXECUTABLE     = "one_vmm_sh",
#    ARGUMENTS      = "-t 15 -r 0 -w 600 -p ec2",
#    TYPE           = "xml",
#    KEEP_SNAPSHOTS = "no",
#    IMPORTED_VMS_ACTIONS = "terminate, terminate-hard, hold, release, suspend,
#        resume, delete, reboot, reboot-hard, resched, unresched, poweroff,
#        poweroff-hard, disk-attach, disk-detach, nic-attach, nic-detach,
#        snap-create, snap-delete"
#]
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  Azure Virtualization Driver Manager Configuration
#    -r number of retries when monitoring a host
#    -t number of threads, i.e. number of actions performed at the same time
#    -w Timeout in seconds to execute external commands (default unlimited)
#-------------------------------------------------------------------------------
#VM_MAD = [
#    NAME           = "az",
#    SUNSTONE_NAME  = "Microsoft Azure",
#    EXECUTABLE     = "one_vmm_sh",
#    ARGUMENTS      = "-t 15 -r 0 az",
#    TYPE           = "xml",
#    KEEP_SNAPSHOTS = "no",
#    IMPORTED_VMS_ACTIONS = "terminate, terminate-hard, hold, release, suspend,
#        resume, delete, reboot, reboot-hard, resched, unresched, poweroff,
#        poweroff-hard, disk-attach, disk-detach, nic-attach, nic-detach,
#        snap-create, snap-delete"
#]
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
#  Dummy Virtualization Driver Configuration
#-------------------------------------------------------------------------------
#VM_MAD = [ NAME="dummy", SUNSTONE_NAME="Testing", EXECUTABLE="one_vmm_dummy",
#  TYPE="xml" ]
#-------------------------------------------------------------------------------

#*******************************************************************************
# Transfer Manager Driver Configuration
#*******************************************************************************
# You can add more transfer managers with different configurations but make
# sure it has different names.
#   name      : name for this transfer driver
#
#   executable: path of the transfer driver executable, can be an
#               absolute path or relative to $ONE_LOCATION/lib/mads (or
#               /usr/lib/one/mads/ if OpenNebula was installed in /)
#   arguments :
#       -t: number of threads, i.e. number of transfers made at the same time
#       -d: list of transfer drivers separated by commas, if not defined all the
#           drivers available will be enabled
#       -w: Timeout in seconds to execute external commands (default unlimited)
#*******************************************************************************

TM_MAD = [
    EXECUTABLE = "one_tm",
    ARGUMENTS = "-t 15 -d dummy,lvm,shared,fs_lvm,qcow2,ssh,ceph,dev,vcenter,iscsi_libvirt"
]

#*******************************************************************************
# Datastore Driver Configuration
#*******************************************************************************
# Drivers to manage the datastores, specialized for the storage backend
#   executable: path of the transfer driver executable, can be an
#               absolute path or relative to $ONE_LOCATION/lib/mads (or
#               /usr/lib/one/mads/ if OpenNebula was installed in /)
#
#   arguments : for the driver executable
#       -t number of threads, i.e. number of repo operations at the same time
#       -d datastore mads separated by commas
#       -s system datastore tm drivers, used to monitor shared system ds.
#       -w Timeout in seconds to execute external commands (default unlimited)
#*******************************************************************************

DATASTORE_MAD = [
    EXECUTABLE = "one_datastore",
    ARGUMENTS  = "-t 15 -d dummy,fs,lvm,ceph,dev,iscsi_libvirt,vcenter -s shared,ssh,ceph,fs_lvm,qcow2"
]

#*******************************************************************************
# Marketplace Driver Configuration
#*******************************************************************************
# Drivers to manage different marketplaces, specialized for the storage backend
#   executable: path of the transfer driver executable, can be an
#               absolute path or relative to $ONE_LOCATION/lib/mads (or
#               /usr/lib/one/mads/ if OpenNebula was installed in /)
#
#   arguments : for the driver executable
#       -t number of threads, i.e. number of repo operations at the same time
#       -m marketplace mads separated by commas
#       --proxy proxy address if required to access the internet
#       -w Timeout in seconds to execute external commands (default unlimited)
#*******************************************************************************

MARKET_MAD = [
    EXECUTABLE = "one_market",
    ARGUMENTS  = "-t 15 -m http,s3,one"
]

#*******************************************************************************
# IPAM Driver Configuration
#*******************************************************************************
# Drivers to manage different IPAMs
#   executable: path of the IPAM driver executable, can be an
#               absolute path or relative to $ONE_LOCATION/lib/mads (or
#               /usr/lib/one/mads/ if OpenNebula was installed in /)
#
#   arguments : for the driver executable
#       -t number of threads, i.e. number of operations at the same time
#       -i IPAM mads separated by commas
#*******************************************************************************

IPAM_MAD = [
    EXECUTABLE = "one_ipam",
    ARGUMENTS  = "-t 1 -i dummy"
]

#*******************************************************************************
# Hook Manager Configuration
#*******************************************************************************
# The Driver (HM_MAD)
# -----------------------------------------------
#
# Used to execute the Hooks:
#   executable: path of the hook driver executable, can be an
#               absolute path or relative to $ONE_LOCATION/lib/mads (or
#               /usr/lib/one/mads/ if OpenNebula was installed in /)
#
#   arguments : for the driver executable, can be an absolute path or relative
#               to $ONE_LOCATION/etc (or /etc/one/ if OpenNebula was installed
#               in /)
#
# Virtual Machine Hooks (VM_HOOK)
# -------------------------------
#
# Defined by:
#   name      : for the hook, useful to track the hook (OPTIONAL)
#   on        : when the hook should be executed,
#               - CREATE, when the VM is created (onevm create)
#               - PROLOG, when the VM is in the prolog state
#               - RUNNING, after the VM is successfully booted
#               - UNKNOWN, when the VM is in the unknown state
#               - SHUTDOWN, after the VM is shutdown
#               - STOP, after the VM is stopped (including VM image transfers)
#               - DONE, after the VM is deleted or shutdown
#               - CUSTOM, user defined specific STATE and LCM_STATE combination
#                 of states to trigger the hook.
#   command   : path is relative to $ONE_LOCATION/var/remotes/hook
#               (self-contained) or to /var/lib/one/remotes/hook (system-wide).
#               That directory will be copied on the hosts under
#               SCRIPTS_REMOTE_DIR. It can be an absolute path that must exist
#               on the target host
#   arguments : for the hook. You can access to VM information with $
#               - $ID, the ID of the virtual machine
#               - $TEMPLATE, the VM template in xml and base64 encoded
#               - $PREV_STATE, the previous STATE of the Virtual Machine
#               - $PREV_LCM_STATE, the previous LCM STATE of the Virtual Machine
#   remote    : values,
#               - YES, The hook is executed in the host where the VM was
#                 allocated
#               - NO, The hook is executed in the OpenNebula server (default)
#
# Example Virtual Machine Hook
# ----------------------------
#
# VM_HOOK = [
#   name      = "advanced_hook",
#   on        = "CUSTOM",
#   state     = "ACTIVE",
#   lcm_state = "BOOT_UNKNOWN",
#   command   = "log.rb",
#   arguments = "$ID $PREV_STATE $PREV_LCM_STATE" ]
#
# Host Hooks (HOST_HOOK)
# -------------------------------
#
# Defined by:
#   name      : for the hook, useful to track the hook (OPTIONAL)
#   on        : when the hook should be executed,
#               - CREATE, when the Host is created (onehost create)
#               - ERROR, when the Host enters the error state
#               - DISABLE, when the Host is disabled
#   command   : path is relative to $ONE_LOCATION/var/remotes/hook
#               (self-contained) or to /var/lib/one/remotes/hook (system-wide).
#               That directory will be copied on the hosts under
#               SCRIPTS_REMOTE_DIR. It can be an absolute path that must exist
#               on the target host.
#   arguments : for the hook. You can use the following Host information:
#               - $ID, the ID of the host
#               - $TEMPLATE, the Host template in xml and base64 encoded
#   remote    : values,
#               - YES, The hook is executed in the host
#               - NO, The hook is executed in the OpenNebula server (default)
#
# Virtual Network (VNET_HOOK)
# Virtual Router (VROUTER_HOOK)
# User (USER_HOOK)
# Group (GROUP_HOOK)
# Image (IMAGE_HOOK)
# -------------------------------
#
# These hooks are executed when one of the referring entities are created or
# removed. Each hook is defined by:
#   name      : for the hook, useful to track the hook (OPTIONAL)
#   on        : when the hook should be executed,
#               - CREATE, when the vnet is created
#               - REMOVE, when the vnet is removed
#   command   : path is relative to $ONE_LOCATION/var/remotes/hook
#               (self-contained) or to /var/lib/one/remotes/hook (system-wide).
#               That directory will be copied on the hosts under
#               SCRIPTS_REMOTE_DIR. It can be an absolute path that must exist
#               on the target host.
#   arguments : for the hook. You can use the following Host information:
#               - $ID, the ID of the host
#               - $TEMPLATE, the vnet template in xml and base64 encoded
#
# Please note: In a Federation, User and Group hooks can only be defined in
# the master OpenNebula.
#-------------------------------------------------------------------------------
HM_MAD = [
    EXECUTABLE = "one_hm" ]

#*******************************************************************************
# Fault Tolerance Hooks
#*******************************************************************************
# This hook is used to perform recovery actions when a host fails.
# Script to implement host failure tolerance
#   One of the following modes must be chosen
#           -m resched VMs to another host. (Only for images in shared storage!)
#           -r recreate VMs running in the host. State will be lost.
#           -d delete VMs running in the host
#
#   Additional flags
#           -f resubmit suspended and powered off VMs (only for recreate)
#           -p <n> avoid resubmission if host comes back after n monitoring
#                 cycles. 0 to disable it. Default is 2.
#           -u disables fencing. Fencing is enabled by default. Don't disable it
#                 unless you are very sure about what you're doing
#*******************************************************************************
#
#HOST_HOOK = [
#    NAME      = "error",
#    ON        = "ERROR",
#    COMMAND   = "ft/host_error.rb",
#    ARGUMENTS = "$ID -m -p 5",
#    REMOTE    = "no" ]
#-------------------------------------------------------------------------------

#*******************************************************************************
# Auth Manager Configuration
#*******************************************************************************
# AUTH_MAD: The Driver that will be used to authenticate (authn) and
# authorize (authz) OpenNebula requests. If defined OpenNebula will use the
# built-in auth policies.
#
#   executable: path of the auth driver executable, can be an
#               absolute path or relative to $ONE_LOCATION/lib/mads (or
#               /usr/lib/one/mads/ if OpenNebula was installed in /)
#
#   authn     : list of authentication modules separated by commas, if not
#               defined all the modules available will be enabled
#   authz     : list of authentication modules separated by commas
#
# DEFAULT_AUTH: The default authentication driver to use when OpenNebula does
# not know the user and needs to authenticate it externally.  If you want to
# use "default" (not recommended, but supported for backwards compatibility
# reasons) make sure you create a symlink pointing to the actual authentication
# driver in /var/lib/one/remotes/auth, and add "default" to the 'auth'
# parameter in the 'AUTH_MAD' section.
#
# SESSION_EXPIRATION_TIME: Time in seconds to keep an authenticated token as
# valid. During this time, the driver is not used. Use 0 to disable session
# caching
#
# ENABLE_OTHER_PERMISSIONS: Whether or not users can set the permissions for
# 'other', so publishing or sharing resources with others. Users in the oneadmin
# group will still be able to change these permissions. Values: YES or NO.
#
# DEFAULT_UMASK: Similar to Unix umask, sets the default resources permissions.
# Its format must be 3 octal digits. For example a umask of 137 will set
# the new object's permissions to 640 "um- u-- ---"
#*******************************************************************************

AUTH_MAD = [
    EXECUTABLE = "one_auth_mad",
    AUTHN = "ssh,x509,ldap,server_cipher,server_x509"
]

#DEFAULT_AUTH = "default"

SESSION_EXPIRATION_TIME = 900

ENABLE_OTHER_PERMISSIONS = "YES"

DEFAULT_UMASK = 177

#*******************************************************************************
# OneGate
#   ONEGATE_ENDPOINT: The URL for the onegate server (the Gate to OpenNebula for
#   VMs). The onegate server is started using a separate command. The endpoint
#   MUST be consistent with the values in onegate-server.conf
#*******************************************************************************

#ONEGATE_ENDPOINT = "http://frontend:5030"

#*******************************************************************************
# Restricted Attributes Configuration
#*******************************************************************************
# The following attributes are restricted to users outside the oneadmin group
#*******************************************************************************

VM_RESTRICTED_ATTR = "CONTEXT/FILES"
VM_RESTRICTED_ATTR = "NIC/MAC"
VM_RESTRICTED_ATTR = "NIC/VLAN_ID"
VM_RESTRICTED_ATTR = "NIC/BRIDGE"
VM_RESTRICTED_ATTR = "NIC/INBOUND_AVG_BW"
VM_RESTRICTED_ATTR = "NIC/INBOUND_PEAK_BW"
VM_RESTRICTED_ATTR = "NIC/INBOUND_PEAK_KB"
VM_RESTRICTED_ATTR = "NIC/OUTBOUND_AVG_BW"
VM_RESTRICTED_ATTR = "NIC/OUTBOUND_PEAK_BW"
VM_RESTRICTED_ATTR = "NIC/OUTBOUND_PEAK_KB"
VM_RESTRICTED_ATTR = "NIC_DEFAULT/MAC"
VM_RESTRICTED_ATTR = "NIC_DEFAULT/VLAN_ID"
VM_RESTRICTED_ATTR = "NIC_DEFAULT/BRIDGE"
VM_RESTRICTED_ATTR = "DISK/TOTAL_BYTES_SEC"
VM_RESTRICTED_ATTR = "DISK/READ_BYTES_SEC"
VM_RESTRICTED_ATTR = "DISK/WRITE_BYTES_SEC"
VM_RESTRICTED_ATTR = "DISK/TOTAL_IOPS_SEC"
VM_RESTRICTED_ATTR = "DISK/READ_IOPS_SEC"
VM_RESTRICTED_ATTR = "DISK/WRITE_IOPS_SEC"
#VM_RESTRICTED_ATTR = "DISK/SIZE"
VM_RESTRICTED_ATTR = "DISK/ORIGINAL_SIZE"
VM_RESTRICTED_ATTR = "CPU_COST"
VM_RESTRICTED_ATTR = "MEMORY_COST"
VM_RESTRICTED_ATTR = "DISK_COST"
VM_RESTRICTED_ATTR = "PCI"
VM_RESTRICTED_ATTR = "EMULATOR"
VM_RESTRICTED_ATTR = "USER_INPUTS/CPU"
VM_RESTRICTED_ATTR = "USER_INPUTS/MEMORY"
VM_RESTRICTED_ATTR = "USER_INPUTS/VCPU"

#VM_RESTRICTED_ATTR = "RANK"
#VM_RESTRICTED_ATTR = "SCHED_RANK"
#VM_RESTRICTED_ATTR = "REQUIREMENTS"
#VM_RESTRICTED_ATTR = "SCHED_REQUIREMENTS"

IMAGE_RESTRICTED_ATTR = "SOURCE"

#*******************************************************************************
# The following restricted attributes only apply to VNets that are a reservation.
# Normal VNets do not have restricted attributes.
#*******************************************************************************

VNET_RESTRICTED_ATTR = "VN_MAD"
VNET_RESTRICTED_ATTR = "PHYDEV"
VNET_RESTRICTED_ATTR = "VLAN_ID"
VNET_RESTRICTED_ATTR = "BRIDGE"

VNET_RESTRICTED_ATTR = "AR/VN_MAD"
VNET_RESTRICTED_ATTR = "AR/PHYDEV"
VNET_RESTRICTED_ATTR = "AR/VLAN_ID"
VNET_RESTRICTED_ATTR = "AR/BRIDGE"

#*******************************************************************************
# Inherited Attributes Configuration
#*******************************************************************************
# The following attributes will be copied from the resource template to the
# instantiated VMs. More than one attribute can be defined.
#
# INHERIT_IMAGE_ATTR: Attribute to be copied from the Image template
# to each VM/DISK.
#
# INHERIT_DATASTORE_ATTR: Attribute to be copied from the Datastore template
# to each VM/DISK.
#
# INHERIT_VNET_ATTR: Attribute to be copied from the Network template
# to each VM/NIC.
#*******************************************************************************

#INHERIT_IMAGE_ATTR     = "EXAMPLE"
#INHERIT_IMAGE_ATTR     = "SECOND_EXAMPLE"
#INHERIT_DATASTORE_ATTR = "COLOR"
#INHERIT_VNET_ATTR      = "BANDWIDTH_THROTTLING"

INHERIT_DATASTORE_ATTR  = "CEPH_HOST"
INHERIT_DATASTORE_ATTR  = "CEPH_SECRET"
INHERIT_DATASTORE_ATTR  = "CEPH_USER"
INHERIT_DATASTORE_ATTR  = "CEPH_CONF"
INHERIT_DATASTORE_ATTR  = "POOL_NAME"

INHERIT_DATASTORE_ATTR  = "ISCSI_USER"
INHERIT_DATASTORE_ATTR  = "ISCSI_USAGE"
INHERIT_DATASTORE_ATTR  = "ISCSI_HOST"

INHERIT_IMAGE_ATTR      = "ISCSI_USER"
INHERIT_IMAGE_ATTR      = "ISCSI_USAGE"
INHERIT_IMAGE_ATTR      = "ISCSI_HOST"
INHERIT_IMAGE_ATTR      = "ISCSI_IQN"

INHERIT_DATASTORE_ATTR  = "GLUSTER_HOST"
INHERIT_DATASTORE_ATTR  = "GLUSTER_VOLUME"

INHERIT_DATASTORE_ATTR  = "DISK_TYPE"
INHERIT_DATASTORE_ATTR  = "ADAPTER_TYPE"

INHERIT_IMAGE_ATTR      = "DISK_TYPE"
INHERIT_IMAGE_ATTR      = "ADAPTER_TYPE"

INHERIT_VNET_ATTR       = "VLAN_TAGGED_ID"
INHERIT_VNET_ATTR       = "FILTER_IP_SPOOFING"
INHERIT_VNET_ATTR       = "FILTER_MAC_SPOOFING"
INHERIT_VNET_ATTR       = "MTU"
INHERIT_VNET_ATTR       = "INBOUND_AVG_BW"
INHERIT_VNET_ATTR       = "INBOUND_PEAK_BW"
INHERIT_VNET_ATTR       = "INBOUND_PEAK_KB"
INHERIT_VNET_ATTR       = "OUTBOUND_AVG_BW"
INHERIT_VNET_ATTR       = "OUTBOUND_PEAK_BW"
INHERIT_VNET_ATTR       = "OUTBOUND_PEAK_KB"

#*******************************************************************************
# Transfer Manager Driver Behavior Configuration
#*******************************************************************************
# The  configuration for each driver is defined in TM_MAD_CONF. These
# values are used when creating a new datastore and should not be modified
# since they define the datastore behavior.
#   name      : name of the transfer driver, listed in the -d option of the
#               TM_MAD section
#   ln_target : determines how the persistent images will be cloned when
#               a new VM is instantiated.
#       NONE: The image will be linked and no more storage capacity will be used
#       SELF: The image will be cloned in the Images datastore
#       SYSTEM: The image will be cloned in the System datastore
#   clone_target : determines how the non persistent images will be
#                  cloned when a new VM is instantiated.
#       NONE: The image will be linked and no more storage capacity will be used
#       SELF: The image will be cloned in the Images datastore
#       SYSTEM: The image will be cloned in the System datastore
#   shared : determines if the storage holding the system datastore is shared
#            among the different hosts or not. Valid values: "yes" or "no"
#   ds_migrate : The driver allows migrations across datastores. Valid values:
#               "yes" or "no". Note: THIS ONLY APPLIES TO SYSTEM DS.
#*******************************************************************************

TM_MAD_CONF = [
    NAME = "dummy", LN_TARGET = "NONE", CLONE_TARGET = "SYSTEM", SHARED = "YES",
    DS_MIGRATE = "YES"
]

TM_MAD_CONF = [
    NAME = "lvm", LN_TARGET = "NONE", CLONE_TARGET = "SELF", SHARED = "YES"
]

TM_MAD_CONF = [
    NAME = "shared", LN_TARGET = "NONE", CLONE_TARGET = "SYSTEM", SHARED = "YES",
    DS_MIGRATE = "YES"
]

TM_MAD_CONF = [
    NAME = "fs_lvm", LN_TARGET = "SYSTEM", CLONE_TARGET = "SYSTEM", SHARED="YES"
]

TM_MAD_CONF = [
    NAME = "qcow2", LN_TARGET = "NONE", CLONE_TARGET = "SYSTEM", SHARED = "YES"
]

TM_MAD_CONF = [
    NAME = "ssh", LN_TARGET = "SYSTEM", CLONE_TARGET = "SYSTEM", SHARED = "NO",
    DS_MIGRATE = "YES"
]

TM_MAD_CONF = [
    NAME = "ceph", LN_TARGET = "NONE", CLONE_TARGET = "SELF", SHARED = "YES",
    DS_MIGRATE = "NO"
]

TM_MAD_CONF = [
    NAME = "iscsi_libvirt", LN_TARGET = "NONE", CLONE_TARGET = "SELF", SHARED = "YES",
    DS_MIGRATE = "NO"
]

TM_MAD_CONF = [
    NAME = "dev", LN_TARGET = "NONE", CLONE_TARGET = "NONE", SHARED = "YES"
]

TM_MAD_CONF = [
    NAME = "vcenter", LN_TARGET = "NONE", CLONE_TARGET = "NONE", SHARED = "YES"
]

#*******************************************************************************
# Datastore Manager Driver Behavior Configuration
#*******************************************************************************
# The  configuration for each driver is defined in DS_MAD_CONF. These
# values are used when creating a new datastore and should not be modified
# since they define the datastore behavior.
#   name      : name of the transfer driver, listed in the -d option of the
#               DS_MAD section
#   required_attrs : comma separated list of required attributes in the DS
#                    template
#   persistent_only: specifies whether the datastore can only manage persistent
#                    images
#*******************************************************************************

DS_MAD_CONF = [
    NAME = "ceph",
    REQUIRED_ATTRS = "DISK_TYPE,BRIDGE_LIST",
    PERSISTENT_ONLY = "NO",
    MARKETPLACE_ACTIONS = "export"
]

DS_MAD_CONF = [
    NAME = "dev", REQUIRED_ATTRS = "DISK_TYPE", PERSISTENT_ONLY = "YES"
]

DS_MAD_CONF = [
    NAME = "iscsi_libvirt", REQUIRED_ATTRS = "DISK_TYPE,ISCSI_HOST",
    PERSISTENT_ONLY = "YES"
]

DS_MAD_CONF = [
    NAME = "dummy", REQUIRED_ATTRS = "", PERSISTENT_ONLY = "NO"
]

DS_MAD_CONF = [
    NAME = "fs", REQUIRED_ATTRS = "", PERSISTENT_ONLY = "NO",
    MARKETPLACE_ACTIONS = "export"
]

DS_MAD_CONF = [
    NAME = "lvm", REQUIRED_ATTRS = "DISK_TYPE,BRIDGE_LIST",
    PERSISTENT_ONLY = "NO"
]

DS_MAD_CONF = [
    NAME = "vcenter", REQUIRED_ATTRS = "VCENTER_CLUSTER", PERSISTENT_ONLY = "YES",
    MARKETPLACE_ACTIONS = "export"
]

#*******************************************************************************
# MarketPlace Driver Behavior Configuration
#*******************************************************************************
# The  configuration for each driver is defined in MARKET_MAD_CONF. These
# values are used when creating a new marketplaces and should not be modified
# since they define the marketplace behavior.
#   name      : name of the market driver
#   required_attrs : comma separated list of required attributes in the Market
#                    template
#   app_actions: List of actions allowed for a MarketPlaceApp
#     - monitor The apps of the marketplace will be monitored
#     - create, the app in the marketplace
#     - delete, the app from the marketplace
#   public: set to yes for external marketplaces. A public marketplace can be
#   removed even if it has registered apps.
#*******************************************************************************

MARKET_MAD_CONF = [
    NAME = "one",
    SUNSTONE_NAME  = "OpenNebula.org Marketplace",
    REQUIRED_ATTRS = "",
    APP_ACTIONS = "monitor",
    PUBLIC = "yes"
]

MARKET_MAD_CONF = [
    NAME = "http",
    SUNSTONE_NAME  = "HTTP server",
    REQUIRED_ATTRS = "BASE_URL,PUBLIC_DIR",
    APP_ACTIONS = "create, delete, monitor"
]

MARKET_MAD_CONF = [
    NAME = "s3",
    SUNSTONE_NAME = "Amazon S3",
    REQUIRED_ATTRS = "ACCESS_KEY_ID,SECRET_ACCESS_KEY,REGION,BUCKET",
    APP_ACTIONS = "create, delete, monitor"
]

#*******************************************************************************
# Authentication Driver Behavior Definition
#*******************************************************************************
# The configuration for each driver is defined in AUTH_MAD_CONF. These
# values must not be modified since they define the driver behavior.
#   name            : name of the auth driver
#   password_change : allow the end users to change their own password. Oneadmin
#                     can still change other user's passwords
#   driver_managed_groups : allow the driver to set the user's group even after
#                     user creation. In this case addgroup, delgroup and chgrp
#                     will be disabled, with the exception of chgrp to one of
#                     the groups in the list of secondary groups
#   max_token_time  : limit the maximum token validity, in seconds. Use -1 for
#                     unlimited maximum, 0 to disable login tokens
#*******************************************************************************

AUTH_MAD_CONF = [
    NAME = "core",
    PASSWORD_CHANGE = "YES",
    DRIVER_MANAGED_GROUPS = "NO",
    MAX_TOKEN_TIME = "-1"
]

AUTH_MAD_CONF = [
    NAME = "public",
    PASSWORD_CHANGE = "NO",
    DRIVER_MANAGED_GROUPS = "NO",
    MAX_TOKEN_TIME = "-1"
]

AUTH_MAD_CONF = [
    NAME = "ssh",
    PASSWORD_CHANGE = "YES",
    DRIVER_MANAGED_GROUPS = "NO",
    MAX_TOKEN_TIME = "-1"
]

AUTH_MAD_CONF = [
    NAME = "x509",
    PASSWORD_CHANGE = "NO",
    DRIVER_MANAGED_GROUPS = "NO",
    MAX_TOKEN_TIME = "-1"
]

AUTH_MAD_CONF = [
    NAME = "ldap",
    PASSWORD_CHANGE = "YES",
    DRIVER_MANAGED_GROUPS = "YES",
    MAX_TOKEN_TIME = "86400"
]

AUTH_MAD_CONF = [
    NAME = "server_cipher",
    PASSWORD_CHANGE = "NO",
    DRIVER_MANAGED_GROUPS = "NO",
    MAX_TOKEN_TIME = "-1"
]

AUTH_MAD_CONF = [
    NAME = "server_x509",
    PASSWORD_CHANGE = "NO",
    DRIVER_MANAGED_GROUPS = "NO",
    MAX_TOKEN_TIME = "-1"
]
