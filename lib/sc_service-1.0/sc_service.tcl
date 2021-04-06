# sc_service.tcl --
#
#   System Console Service: Console Commands
#
# https://www.intel.co.jp/content/dam/altera-www/global/ja_JP/pdfs/literature/ug/ug_system_console.pdf

package provide sc_service 1.0

proc create_sc_service {} {

    uplevel 1 {


        namespace eval sc_service {

            variable service_type_name {master}
            variable service_index     0
            variable service_path      {}

            namespace export          \
                set_service_type_name \
                get_service_type_name \
                set_service_index     \
                get_service_index     \
                get_accessible_paths  \
                set_service_path      \
                get_service_path      \
                open_service_path     \
                close_service_path    \
                is_service_path_open
        }

        proc sc_service::set_service_type_name {name} {
            variable service_type_name
            set service_type_name $name
        }

        proc sc_service::get_service_type_name {} {
            variable service_type_name
            return $service_type_name
        }

        proc sc_service::set_service_index {value} {
            variable service_index
            set service_index $value
        }

        proc sc_service::get_service_index {} {
            variable service_index
            return $service_index
        }

        # sc_service::get_accessible_paths --
        #
        # Arguments:
        #   type_name - service type name; existing value used as default
        #
        # Results:
        #   Returns a list of paths to nodes that implement the requested service type.

        proc sc_service::get_accessible_paths {{type_name ""}} {
            variable service_type_name
            if {$type_name eq ""} {
                set type_name $service_type_name
            }

            # Command 'get_service_paths' is Console Command

            return [get_service_paths $type_name]
        }

        # sc_service::set_service_path --
        #
        #   Command to set service path.
        #   Command also may set values of (if they are define):
        #   <service_type_name>, <service_index>.
        #
        # Arguments:
        #   index     - index of service type; existing value used as default
        #   type_name - service type name; existing value used as default

        proc sc_service::set_service_path {{index ""} {type_name ""}} {
            variable service_index
            variable service_type_name
            variable service_path
            if { $index ne ""} {
                set service_index $index
            }
            if {$type_name ne ""} {
                set service_type_name $type_name
            }
            set available_paths [get_accessible_paths $service_type_name]
            set service_path [lindex $available_paths $service_index]
        }

        # sc_service::get_service_path --
        #
        # Results:
        #   Return <service_path> for current values of <service_type_name>, <service_index>

        proc sc_service::get_service_path {} {
            variable service_path
            return $service_path
        }

        # sc_service::open_service_path --
        #
        #   Opens the service type for current values of <service_type_name>, <service_index>

        proc sc_service::open_service_path {} {
            variable service_type_name
            variable service_path

            # Command 'open_service' is Console Command

            open_service $service_type_name $service_path
        }

        # sc_service::close_service_path --
        #
        #   Closes the service type for current values of <service_type_name>, <service_index>

        proc sc_service::close_service_path {} {
            variable service_type_name
            variable service_path

            # Command 'close_service' is Console Command

            close_service $service_type_name $service_path
        }

        # sc_service::is_service_path_open --
        #
        # Results:
        #   Returns 1 if the service type for current values of <service_type_name>, <service_index>
        #   is open, 0 if the service type is closed.

        proc sc_service::is_service_path_open {} {
            variable service_type_name
            variable service_path

            # Command 'is_service_open' is Console Command

            return [is_service_open $service_type_name $service_path]
        }


    } ; # uplevel 1

} ; # proc create_sc_service
