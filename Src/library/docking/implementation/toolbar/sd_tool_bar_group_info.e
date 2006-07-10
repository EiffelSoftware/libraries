indexing
	description: "Objects that store tool bar items group infomation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_GROUP_INFO

inherit
	ANY
		redefine
			out
		end

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method.
		do
			create internal_group_info.make (1)
			create internal_is_new_group.make (1)
			create sub_grouping.make_default
		end

feature -- Query

	total_items_count: INTEGER is
			-- How many items.
		do
			from
				internal_group_info.start
			until
				internal_group_info.after
			loop
				Result := Result + internal_group_info.item.count
				internal_group_info.forth
			end
		ensure
			valid: Result >= 0
		end

	maximum_width_sub: INTEGER is
			-- Maximum width
			-- Calculation include sub level items.
		local
			l_maximum_index: INTEGER
		do
			l_maximum_index := maximum_width_group_index
			if not has_sub_info then
			-- This function is calculate inlclude sub level
			-- But it's not calcule sub sub level, so we pass True here
				Result := group_maximum_width (l_maximum_index)
			else
				Result := sub_grouping.item (l_maximum_index).maximum_width_sub
			end
		end

	maximum_width: INTEGER is
			-- Maximum width
			-- The calculation not include sub level groups.
		local
			l_snapshot: like internal_group_info
			l_new_group_snapshot: like internal_is_new_group
			l_temp_size: INTEGER
		do
			from
				l_snapshot := internal_group_info.twin
				l_new_group_snapshot := internal_is_new_group.twin
				check same_size: l_new_group_snapshot.count = l_snapshot.count end
				l_snapshot.start
				l_new_group_snapshot.start
			until
				l_snapshot.after or l_new_group_snapshot.after
			loop
				l_snapshot.item.finish
				if l_new_group_snapshot.item then
					l_temp_size := 0
				end
				l_temp_size := l_temp_size + l_snapshot.item.value (l_snapshot.item.key_for_iteration)
				if l_temp_size > Result then
					Result := l_temp_size
				end
				l_snapshot.forth
				l_new_group_snapshot.forth
			end
		end

	maximum_width_group_index: INTEGER is
			-- Maximum width group index.
			-- It compute sub-level groups
		local
			l_group_count: INTEGER
			l_total_group: INTEGER
			l_maximum_width: INTEGER
			l_group_width: INTEGER
		do
			from
				l_group_count := 1
				l_total_group := group_count
			until
				l_group_count > l_total_group
			loop
				l_group_width := group_maximum_width (l_group_count)

				if l_group_width > l_maximum_width then
					l_maximum_width := l_group_width
					Result := l_group_count
				end
				l_group_count := l_group_count + 1
			end

		ensure
			valid: Result > 0 and Result <= group_count
		end

	maximum_width_top_group: SD_TOOL_BAR_GROUP_INFO is
			-- The group which have maximum width.
			-- The maximum width calculation inlucde sub level group items width calculation.
		local
			l_result_index: INTEGER
		do
			l_result_index := maximum_width_top_group_index
			create Result.make
			go_i_th (l_result_index)
			if not has_sub_info then
				Result.extend (item, True)
			else
				Result := sub_grouping.item (l_result_index)
			end
		end

	maximum_width_top_group_index: INTEGER is
			-- Maximum width top group index.
			-- Calculation include sub level items width.
		local
			l_group_count: INTEGER
			l_total_group: INTEGER
			l_maximum_width: INTEGER
			l_group_width: INTEGER
		do
			from
				l_group_count := 1
				l_total_group := group_count
			until
				l_group_count > l_total_group
			loop

				l_group_width := group_maximum_width (l_group_count)
				if l_group_width > l_maximum_width then
					l_maximum_width := l_group_width
					Result := l_group_count
				end

				l_group_count := l_group_count + 1
			end
		ensure
			valid: Result > 0 and Result <= total_group_count
		end

	group_width (a_group_index: INTEGER): INTEGER is
			-- Group width
			-- Calculation include sub level items.
		require
			valid: a_group_index > 0 and a_group_index <= total_group_count
		local
			l_count_include_sub: INTEGER
			l_sub_group_info: SD_TOOL_BAR_GROUP_INFO
			l_stop: BOOLEAN
			l_sub_group_count: INTEGER
		do
			from
				l_count_include_sub := 1
				start
			until
				after or l_count_include_sub > a_group_index or l_stop
			loop
				if is_new_group then
					l_count_include_sub := l_count_include_sub + 1
				end
				if has_sub_info then
					l_sub_group_info := sub_grouping.item (index)
					from
						l_sub_group_info.start
						l_sub_group_count := 1
					until
						l_sub_group_info.after or l_stop
					loop
						if l_sub_group_info.is_new_group then
							l_count_include_sub := l_count_include_sub + 1
						end
						if l_count_include_sub = a_group_index then
							l_stop := True
							Result := l_sub_group_info.row_width (l_sub_group_count)
						end
						l_sub_group_info.forth
						l_sub_group_count := l_sub_group_count + 1
					end
				else
					if l_count_include_sub = a_group_index then
						l_stop := True
						Result := row_width (index)
					end
				end
				forth
			end
		end

	group_maximum_width (a_group_index: INTEGER): INTEGER is
			-- Maximum group width of a_group_index.
			-- `a_group_index' is top level group index.
		require
			valid: a_group_index > 0 and a_group_index <= group_count
		local
			l_group_count: INTEGER
			l_index_count, l_index_max: INTEGER
			l_temp_result: INTEGER
		do
			from
				l_group_count := 1
				l_index_count := 1
				l_index_max := count
			until

				l_index_count > l_index_max or l_group_count > a_group_index
			loop
				go_i_th (l_index_count)
				if is_new_group then
					l_group_count := l_group_count + 1
				end
				if l_group_count = a_group_index then
					go_i_th (l_index_count)
					if not has_sub_info then
						l_temp_result := row_width (l_index_count)
					else
						l_temp_result := sub_grouping.item (l_index_count).maximum_width
					end
					if l_temp_result > Result then
						Result := l_temp_result
					end
				end
				l_index_count := l_index_count + 1
			end
		ensure
			valid: Result >= 0
		end

	row_width (a_row_index: INTEGER): INTEGER is
			-- Row width.
		require
			valid: a_row_index > 0 and a_row_index <= row_count
		local
			l_row: DS_HASH_TABLE [INTEGER, INTEGER]
		do
			l_row := internal_group_info.i_th (a_row_index)
			from
				l_row.start
			until
				l_row.after
			loop
				Result := l_row.value (l_row.key_for_iteration) + Result
				l_row.forth
			end
		ensure
			valid: Result >= 0
		end

	row_count: INTEGER is
			-- Row count
		do
			Result := internal_group_info.count
		end

	row_total_count: INTEGER is
			-- Total row count.
		do
			from
				start
			until
				after
			loop
				if has_sub_info then
					Result := sub_grouping.item (index).count + Result
				else
					Result := Result + 1
				end
				forth
			end
		ensure
			valid: Result >= 0
		end

	group_count: INTEGER is
			-- Group count. Start from 1 (not 0).
		do
			Result := 1
			from
				start
			until
				after
			loop
				if index /= 1 and then is_new_group then
					Result := Result + 1
				end
				forth
			end
		ensure
			valid: Result >= 0
		end

	total_group_count: INTEGER is
			-- Total group count, include sub group count.
		do
			Result := 1
			from
				start
			until
				after
			loop
				if is_new_group and not has_sub_info then
					Result := Result + 1
				end
				if has_sub_info then
					check sub_group_must_new_group: index /= 1 implies is_new_group end
					Result := Result + sub_grouping.item (index).total_group_count
					if index = 1 then
						-- We alreay plus 1 when index = 1
						-- So we should subtract 1
						Result := Result - 1
					end
				end
				forth
			end
		end

	group_item_count (a_group_index: INTEGER): INTEGER is
			-- How many items in a group.
		require
			valid: a_group_index > 0 and a_group_index <= group_count
		local
			l_group_count: INTEGER
		do
			from
				l_group_count := 1
				start
			until
				after or l_group_count > a_group_index
			loop
				if is_new_group then
					l_group_count := l_group_count + 1
				end
				if l_group_count = a_group_index then
					Result := item.count + Result
				end
				forth
			end
		ensure
			valid: Result > 0
		end

	group_item_start_index (a_group_index: INTEGER): INTEGER is
			-- Group item start index.
		require
			valid: a_group_index > 0 and a_group_index <= group_count
		local
			l_item: DS_HASH_TABLE [INTEGER, INTEGER]
		do
			go_group_i_th (a_group_index)
			l_item := item
			l_item.start
			Result := l_item.key_for_iteration
		end

	sub_grouping: DS_HASH_TABLE [SD_TOOL_BAR_GROUP_INFO ,INTEGER]
			-- SD_tool_bar_GROUP_INFO is grouping info of items in one tool bar items group.
			-- INTEGER is tool bar items group id. It is INTEGER in `internal_group_info'.

feature -- Command

	set_sub_group_info (a_sub_grouping_info: SD_TOOL_BAR_GROUP_INFO; a_group_index: INTEGER) is
			-- Set sub grouping info.
		require
			valid: a_group_index > 0 and a_group_index <= count
		do
			sub_grouping.force (a_sub_grouping_info, a_group_index)
		ensure
			has: sub_grouping.has_item (a_sub_grouping_info)
		end

	out: STRING is
			-- Redefine
		do
			Result := "%NSD_TOOL_BAR_GROUP_INFO:"
			Result := Result + "%N                   group count: " + group_count.out
			Result := Result + "%N                   total item count: " + total_items_count.out
			Result := Result + "%N                   total group count: " + total_group_count.out
			Result := Result + "%N                   ==========================================="
			from
				start
			until
				after
			loop
				Result := Result + "%N                   is_new_group? " + is_new_group.out
				Result := Result + "%N                   has_sub_group?" + has_sub_info.out
				Result := Result + "%N                   -------------------------------------------"
				if has_sub_info then
					Result := Result + "%N                   <<<<<<<<<<<<< sub info start >>>>>>>>>>>>>> "
					Result := Result + sub_grouping.item (index).out
					Result := Result + "%N                   <<<<<<<<<<<<< sub info end >>>>>>>>>>>>>> "
				end
				forth
			end
			Result := Result + "%N                   ==========================================="
		end

feature -- Query for iteration

	after: BOOLEAN is
			-- If no items left?
		do
			Result := internal_group_info.after
		end

	before: BOOLEAN is
			-- If no items before?
		do
			Result := internal_group_info.before
		end

	count: INTEGER is
			-- Count of how many rows.
		do
			Result := internal_group_info.count
		end

	index: INTEGER is
			-- Index of current row.
		do
			Result := internal_group_info.index
		end

	item: DS_HASH_TABLE [INTEGER, INTEGER] is
			-- One row info.
		do
			Result := internal_group_info.item
		end

	has_sub_info: BOOLEAN is
			-- Do current index has sub grouping information?
		do
			Result := sub_grouping.has (index)
		end

	i_th (a_index: INTEGER): DS_HASH_TABLE [INTEGER, INTEGER] is
			-- Item at a_index.
		do
			Result := internal_group_info.i_th (a_index)
		end

	is_new_group: BOOLEAN is
			-- If current `item' is new group base on last `item'?
		do
			Result := internal_is_new_group.item
		end

feature -- Command for iteration

	start is
			-- Go to first item.
		do
			internal_group_info.start
			internal_is_new_group.start
		end

	finish is
			-- Go to last position.
		do
			internal_group_info.finish
			internal_is_new_group.finish
		end

	forth is
			-- Go to next row info.
		do
			internal_group_info.forth
			internal_is_new_group.forth
		end

	back is
			-- Go to row info before.
		do
			internal_group_info.back
			internal_is_new_group.back
		end

	extend (a_group_index_info: DS_HASH_TABLE [INTEGER, INTEGER]; a_new_group: BOOLEAN) is
			-- Extend a_group_info
		require
			not_void:a_group_index_info /= Void
		do
			internal_group_info.extend (a_group_index_info)
			internal_is_new_group.extend (a_new_group)
		ensure
			same_size: internal_group_info.count = internal_is_new_group.count
		end

	go_i_th (a_index: INTEGER) is
			-- Go to `a_index' position.
		do
			internal_group_info.go_i_th (a_index)
			internal_is_new_group.go_i_th (a_index)
		end

	replace (a_item: DS_HASH_TABLE [INTEGER, INTEGER]; a_new_group: BOOLEAN) is
			-- Replace current item by a_item.
		do
			internal_group_info.replace (a_item)
			internal_is_new_group.replace (a_new_group)
		end

feature {NONE} -- Implementation

	go_group_i_th (a_group_index: INTEGER) is
			-- Move index to a_group_index
		require
			valid: a_group_index > 0
		local
			l_group_count: INTEGER
			l_stop: BOOLEAN
		do
			from
				l_group_count := 1
				start
			until
				after or l_stop
			loop
				if is_new_group then
					l_group_count := l_group_count + 1
				end
				if l_group_count = a_group_index then
					l_stop := True
				else
					forth
				end
			end
		ensure
			not_after: not after
		end

	internal_group_info: ARRAYED_LIST [DS_HASH_TABLE [INTEGER, INTEGER]]
			-- Grouping formation.
			-- The order of items in arrayed list is the same order as ..........
			-- 1st INTEGER Store each item in `internal_group_info's width or it's serval SD_TOOL_BAR_ITEMs' width.			
			-- 2nd INTEGER is group_index of SD_TOOL_BAR_CONTENT.

	internal_is_new_group: ARRAYED_LIST [BOOLEAN]
			-- Store each item in `internal_group_info' is a new row?

invariant
	not_void: internal_group_info /= Void
	same_size: internal_group_info.count = internal_is_new_group.count

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end
