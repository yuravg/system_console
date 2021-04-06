# sc_avalonmm.tcl --
#
#   System Console Service: Avalon-MM Commands
#
# https://www.intel.co.jp/content/dam/altera-www/global/ja_JP/pdfs/literature/ug/ug_system_console.pdf

package provide sc_avalonmm 1.0

package require sc_service

namespace eval sc_avalonmm {

    create_sc_service

    variable service_path

    namespace export       \
        set_service_path   \
        close_service_path \
        read8              \
        read16             \
        read32             \
        write8             \
        write16            \
        write32
}

# sc_avalonmm::set_service_path --
#
#   Command to set service path.
#   Command also may set values of (if they are define):
#   <service_type_name>, <service_index>.
#
# Arguments:
#   index     - index of service type; existing value used as default
#   type_name - service type name; existing value used as default

proc sc_avalonmm::set_service_path {{index ""} {type_name ""}} {
    sc_service::set_service_path $index $type_name

    variable service_path [sc_service::get_service_path]
}

# sc_avalonmm::close_service_path --
#
#   Closes the service type for current values of <service_type_name>, <service_index>

proc sc_avalonmm::close_service_path {} {
    sc_service::close_service_path
}

proc sc_avalonmm::open_service_if_requred {} {
    variable service_path
    if {![sc_service::is_service_path_open]} {
        sc_service::open_service_path
    }
}

# sc_avalonmm::read8 --
#
#   Read 8-bit value(s)
#
# Arguments:
#   addr - read address; address given in hexadecimal format with the 0x prefix
#   size_in_bytes - requested data size
#
# Results:
#   returns read values or a list of read values delineated by spaces;
#   return value(s) in hexadecimal format with the 0x prefix.

proc sc_avalonmm::read8 {addr size_in_bytes} {
    variable service_path
    open_service_if_requred
    return [master_read_8 $service_path $addr $size_in_bytes]
}

# sc_avalonmm::read16 --
#
#   Read 16-bit value(s)
#
# Arguments:
#   addr - read address; address given in hexadecimal format with the 0x prefix
#   size_in_multiples_of_16_bits - requested data size
#
# Results:
#   returns read values or a list of read values delineated by spaces;
#   return value(s) in hexadecimal format with the 0x prefix.

proc sc_avalonmm::read16 {addr size_in_multiples_of_16_bits} {
    variable service_path
    open_service_if_requred
    return [master_read_16 $service_path $addr $size_in_multiples_of_16_bits]
}

# sc_avalonmm::read32 --
#
#   Read 32-bit value(s)
#
# Arguments:
#   addr - read address; address given in hexadecimal format with the 0x prefix
#   size_in_bytes - requested data size
#
# Results:
#   returns read values or a list of read values delineated by spaces;
#   return value(s) in hexadecimal format with the 0x prefix.

proc sc_avalonmm::read32 {addr size_in_multiples_of_32_bits} {
    variable service_path
    open_service_if_requred
    return [master_read_32 $service_path $addr $size_in_multiples_of_32_bits]
}

# sc_avalonmm::write8 --
#
#   Write 8-bit value(s)
#
# Arguments:
#   addr - write address; address given in hexadecimal format with the 0x prefix
#   list_of_byte_values - data or list of data (delineated by spaces) to write;
#       data given in hexadecimal format with the 0x prefix

proc sc_avalonmm::write8 {addr list_of_byte_values} {
    variable service_path
    open_service_if_requred
    master_write_8 $service_path $addr $list_of_byte_values
}

# sc_avalonmm::write16 --
#
#   Write 16-bit value(s)
#
# Arguments:
#   addr - write address; given in hexadecimal format with the 0x prefix
#   list_of_byte_values - data or list of data (delineated by spaces) to write;
#       data given in hexadecimal format with the 0x prefix

proc sc_avalonmm::write16 {addr list_of_byte_values} {
    variable service_path
    open_service_if_requred
    master_write_16 $service_path $addr $list_of_byte_values
}

# sc_avalonmm::write32 --
#
#   Write 32-bit value(s)
#
# Arguments:
#   addr - write address; given in hexadecimal format with the 0x prefix
#   list_of_byte_values - data or list of data (delineated by spaces) to write;
#       data given in hexadecimal format with the 0x prefix

proc sc_avalonmm::write32 {addr list_of_byte_values} {
    variable service_path
    open_service_if_requred
    master_write_32 $service_path $addr $list_of_byte_values
}
