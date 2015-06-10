<style type="text/css">
	#delete-selected-history {
		float:right;
	}
	
	#today-hide-or-show, #this-week-hide-or-show, #this-month-hide-or-show, #others-hide-or-show {
		cursor: pointer;
	}
</style>


<script type="text/javascript">
	var allReturnedhistory =' ${ allFoundHistory }';
    var historyAfterparse = JSON.parse(allReturnedhistory).reverse();
    var jq = jQuery;
	
    
    jq(document).ready(function() {
    	displayHistoryExistingHistory();
    	jq("#this-weeks-history-section").hide();
    	jq("#this-month-history-section").hide();
    	jq("#others-history-section").hide();
    	
    	jq("#today-hide-or-show").click(function(event) {
    		hideOrShowHistorySection("#today-hide-or-show", "#todays-history-section");
    	});
    	
    	jq("#this-week-hide-or-show").click(function(event) {
    		hideOrShowHistorySection("#this-week-hide-or-show", "#this-weeks-history-section");
    	});
    	
    	jq("#this-month-hide-or-show").click(function(event) {
    		hideOrShowHistorySection("#this-month-hide-or-show", "#this-month-history-section");
    	});
    	
    	jq("#others-hide-or-show").click(function(event) {
    		hideOrShowHistorySection("#others-hide-or-show", "#others-history-section");
    	});
    	
    	jq("#history-check-all-today").click(function(event) {
    		checkOrUnAllOtherCheckBoxesInADiv("#todays-history-section", "history-check-all-today");
    	});
    	
    	jq("#history-check-all-week").click(function(event) {
    		checkOrUnAllOtherCheckBoxesInADiv("#this-weeks-history-section", "history-check-all-week");
    	});
    	
    	jq("#history-check-all-month").click(function(event) {
    		checkOrUnAllOtherCheckBoxesInADiv("#this-month-history-section", "history-check-all-month");
    	});
    	
    	jq("#history-check-others").click(function(event) {
    		checkOrUnAllOtherCheckBoxesInADiv("#others-history-section", "history-check-others");
    	});
    	
    	jq("#delete-selected-history").click(function(event) {
    		deleteAllSelectedHistory();
    	});
    	
    	function displayHistoryExistingHistory() {
    		var thHistoryToday = "";
    		var thHistoryWeek = "";
    		var thHistoryMonth = "";
    		var thHistoryOther = "";
    		var tableTodayHeader = "<tr><th><label><input type='checkbox' id='history-check-all-today' > Select (PatientId)</label></th><th>Time</th><th>Search Phrase</th></tr>";
    		var tableWeekHeader = "<tr><th><label><input type='checkbox' id='history-check-all-week' > Select (PatientId)</label></th><th>Date && Time</th><th>Search Phrase</th></tr>";
    		var tableMonthHeader = "<tr><th><label><input type='checkbox' id='history-check-all-month' > Select (PatientId)</label></th><th>Date && Time</th><th>Search Phrase</th></tr>";
    		var tableOthersHeader = "<tr><th><label><input type='checkbox' id='history-check-others' > Select (PatientId)</label></th><th>Date && Time</th><th>Search Phrase</th></tr>";
    		
    		if(historyAfterparse.length !== 0) {
    			for (i = 0; i < historyAfterparse.length; i++) {
    				var history = historyAfterparse[i];
    				var date = new Date(history.lastSearchedAt);
    				
    				if(checkIfDateIsToday(history.lastSearchedAt)) {
    					thHistoryToday += "<tr><td><label><input type='checkbox' id='" + history.uuid + "' class='history-check' > (" + history.patientId + ")</label></td><td>" + date.toTimeString() + "</td><td>" + history.searchPhrase + "</td></tr>";
    				}
    				if(checkIfDateIsForThisWeek(history.lastSearchedAt) && !checkIfDateIsToday(history.lastSearchedAt)) {
    					thHistoryWeek += "<tr><td><label><input type='checkbox' id='" + history.uuid + "' class='history-check' > (" + history.patientId + ")</label></td><td>" + date.toString() + "</td><td>" + history.searchPhrase + "</td></tr>";
    				}
    				if(checkIfDateIsInCurrentMonth(history.lastSearchedAt) && !checkIfDateIsForThisWeek(history.lastSearchedAt)) {
    					thHistoryMonth += "<tr><td><label><input type='checkbox' id='" + history.uuid + "' class='history-check' > (" + history.patientId + ")</label></td><td>" + date.toString() + "</td><td>" + history.searchPhrase + "</td></tr>";
    				}
    				if(!checkIfDateIsInCurrentMonth(history.lastSearchedAt)) {
    					thHistoryOther += "<tr><td><label><input type='checkbox' id='" + history.uuid + "' class='history-check' > (" + history.patientId + ")</label></td><td>" + date.toString() + "</td><td>" + history.searchPhrase + "</td></tr>";
    				}
    			}
    		}
    		
    		if(thHistoryToday !== "") {
    			jq("#todays-history").html(tableTodayHeader + thHistoryToday);
    		}
    		if(thHistoryWeek !== "") {
    			jq("#this-weeks-history").html(tableWeekHeader + thHistoryWeek);
    		}
    		
    		if(thHistoryMonth !== "") {
    			jq("#this-month-history").html(tableMonthHeader + thHistoryMonth);
    		}
    		
    		if(thHistoryOther !== "") {
    			jq("#other-history").html(tableOthersHeader + thHistoryOther);
    		}
    	}
    	
    	function checkIfDateIsToday(dateTime) {
			var inputDate = new Date(dateTime);
			var todaysDate = new Date();
			
			if(inputDate.setHours(0,0,0,0) === todaysDate.setHours(0,0,0,0)) {
			    return true;
			} else {
				return false;
			}
    	}
    	
    	function checkIfDateIsForThisWeek(dateTime) {
    		var date = new Date(dateTime);
    		var now = new Date();
    		
    		if(date.getYear() === now.getYear() && date.getMonth() === now.getMonth() && date.getDay() >= 0 && date.getDay() <= 6) {
    			return true;
    		} else {
    			return false;
    		}
    	}
    	
    	function checkIfDateIsInCurrentMonth(dateTime) {
    		var date = new Date(dateTime);
    		var now = new Date();
    		
    		if(date.getYear() === now.getYear() && date.getMonth() === now.getMonth()) {
    			return true;
    		} else {
    			return false;
    		}
    	}
    	
    	function hideOrShowHistorySection(iconElement, divElement) {
    		if(jq(divElement).is(':visible')) {
    			jq(iconElement).removeClass("icon-circle-arrow-down");
    			jq(iconElement).addClass("icon-circle-arrow-right");
    			jq(divElement + " :input").attr("disabled", true);
    			jq(divElement).hide();
    		} else {
    			jq(iconElement).removeClass("icon-circle-arrow-right");
    			jq(iconElement).addClass("icon-circle-arrow-down");
    			jq(divElement + " :input").attr("disabled", false);
    			jq(divElement).show();
    		}
    	}
    	
    	function returnuuidsOfSeletedHistory() {
	    	var selectedHistoryUuids = [];
	    	
			jq('#manage-history input:checked').each(function() {
				var selectedId = jq(this).attr("id");
				
				if(selectedId !== "history-check-all-today" && selectedId !== "history-check-all-week" && selectedId !== "history-check-others" && selectedId !== "history-check-all-month" && !jq("#" + selectedId).is(":disabled")) {
			    	selectedHistoryUuids.push(selectedId);
			    }
			});
			return selectedHistoryUuids;
    	}
    	
    	function checkOrUnAllOtherCheckBoxesInADiv(divElement, skipId) {
    		jq(divElement + " input").each(function(event) {
    			var selectedId = jq(this).attr("id");
				
				if(selectedId !== skipId) {
					if(jq("#" + skipId).is(":checked")) {
		    			jq(this).prop("checked", true);
		    		} else {
		    			jq(this).prop("checked", false);
		    		}
	    		}
    		});
    	}
    	
    	function deleteAllSelectedHistory() {
    		var selectedUuids = returnuuidsOfSeletedHistory();
    		var deleteConfirmMsg = "Are you sure you want to delete " + selectedUuids.length + " Item(s)!";
    		
    		if(selectedUuids.length !== 0) {
	    		if(confirm(deleteConfirmMsg)) {
	    			jq.ajax({
						type: "POST",
						url: "${ ui.actionLink('deleteSelectedHistory') }",
						data: {"selectedUuids":selectedUuids},
						dataType: "json",
						success: function(remainingHistory) {
							historyAfterparse = remainingHistory;
							
							displayHistoryExistingHistory();
						},
						error: function(e) {
						}
					});
	    		} else {
	    			//alert("DELETE Cancelled");
	    		}
    		} else {
    			alert("Select at-least one history to be deleted!");
    		}
    	}
    	
    });
</script>

<h1>Manage History</h1>
<input type="button" id="delete-selected-history" value="Delete Selected"/><br /><br />
<div id="manage-history">
	<i class="icon-circle-arrow-down" id="today-hide-or-show"> Today</i><br />
	<div id="todays-history-section">
		<table id="todays-history"></table>
	</div>
	<br />
	<i class="icon-circle-arrow-right" id="this-week-hide-or-show"> This Week Excluding Today</i><br />
	<div id="this-weeks-history-section">
		<table id="this-weeks-history"></table>
	</div>
	<br />
	<i class="icon-circle-arrow-right" id="this-month-hide-or-show"> This Month Excluding This week</i><br />	
	<div id="this-month-history-section">
		<table id="this-month-history"></table>
	</div>
	<br />
	<i class="icon-circle-arrow-right" id="others-hide-or-show"> Others Months & years</i><br />	
	<div id="others-history-section">
		<table id="other-history"></table>
	</div>
</div>
