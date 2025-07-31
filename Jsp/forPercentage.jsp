<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!-- CSRF token for Spring Security (if used) -->
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />

<script src="${contextPath}/assets/appJs/validation/common-utils.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootbox@5.5.2/bootbox.min.js"></script>

<div class="content">
  <!-- HEADER AND FORM CONTENT (unchanged) -->
  <!-- ... your previous layout remains untouched ... -->

  <!-- STUDENT EDUCATION SECTION -->
  <div class="col-md-6">
    <div class="col-md-12">
      <h4 class="card-title">Add Student Education Details</h4>
    </div>

    <div class="col-md-12 mt-2">
      <input type="hidden" id="rowLengthEdu" value="${empty studentEducationList ? 1 : studentEducationList.size()}"/>

      <table class="table table-bordered">
        <thead>
          <tr>
            <th>Institute Name</th>
            <th>Board</th>
            <th>Full Marks</th>
            <th>Secured Marks</th>
            <th>Percentage</th>
            <th>Action</th>
          </tr>
        </thead>
        <tbody id="educationRow">
          <tr id="deleteRowEdu1">
            <td><input type="text" class="form-control form-control-sm" name="studentEducation[0].instituteName" id="instituteName1" /></td>
            <td><input type="text" class="form-control form-control-sm" name="studentEducation[0].board" id="board1" /></td>
            <td><input type="number" class="form-control form-control-sm" name="studentEducation[0].fullMarks" id="fullMarks1" /></td>
            <td><input type="number" class="form-control form-control-sm" name="studentEducation[0].securedMarks" id="securedMarks1" /></td>
            <td><input type="text" readonly class="form-control form-control-sm" name="studentEducation[0].percentage" id="percentage1" /></td>
            <td class="text-center">
              <button type="button" class="btn btn-xs btn-primary" onclick="addEducationDetails()"><i class="fa fa-plus"></i></button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- SCRIPT SECTION -->
<script type="text/javascript">

  // Percentage calculation on blur of securedMarks
  $(document).on('blur', 'input[id^="securedMarks"]', function () {
    var rowNum = $(this).attr('id').replace('securedMarks', '');
    var fullMarks = $('#fullMarks' + rowNum).val().trim();
    var securedMarks = $('#securedMarks' + rowNum).val().trim();

    if (fullMarks !== '' && securedMarks !== '') {
      bootbox.alert("Full Marks: " + fullMarks + " | Secured Marks: " + securedMarks);

      var token = $("meta[name='_csrf']").attr("content");
      var header = $("meta[name='_csrf_header']").attr("content");

      $.ajax({
        type: 'POST',
        url: '/calculate-percentage',
        data: {
          fullMarks: fullMarks,
          securedMarks: securedMarks
        },
        beforeSend: function(xhr) {
          if (token && header) {
            xhr.setRequestHeader(header, token);
          }
        },
        success: function (response) {
          $('#percentage' + rowNum).val(response + "%");
        },
        error: function () {
          bootbox.alert("Failed to calculate percentage.");
        }
      });
    }
  });

  function addEducationDetails() {
    var count = parseInt($("#rowLengthEdu").val());
    var inst = $("#instituteName" + count).val();
    var board = $("#board" + count).val();
    var full = $("#fullMarks" + count).val();
    var sec = $("#securedMarks" + count).val();

    if (inst && board && full && sec) {
      var next = count + 1;
      var index = count;

      var html = '<tr id="deleteRowEdu' + next + '">' +
        '<td><input type="text" class="form-control form-control-sm" name="studentEducation[' + index + '].instituteName" id="instituteName' + next + '" /></td>' +
        '<td><input type="text" class="form-control form-control-sm" name="studentEducation[' + index + '].board" id="board' + next + '" /></td>' +
        '<td><input type="number" class="form-control form-control-sm" name="studentEducation[' + index + '].fullMarks" id="fullMarks' + next + '" /></td>' +
        '<td><input type="number" class="form-control form-control-sm" name="studentEducation[' + index + '].securedMarks" id="securedMarks' + next + '" /></td>' +
        '<td><input type="text" class="form-control form-control-sm" readonly name="studentEducation[' + index + '].percentage" id="percentage' + next + '" /></td>' +
        '<td><button type="button" class="btn btn-danger btn-xs" id="btnMinusEdu' + next + '" onclick="deleteEducationRow(' + next + ')"><i class="fa fa-minus"></i></button></td>' +
        '</tr>';

      $("#educationRow").append(html);
      $("#rowLengthEdu").val(next);
      $("#btnMinusEdu" + count).attr("disabled", true);
    } else {
      bootbox.alert("Please fill all fields before adding a new row.");
    }
  }

  function deleteEducationRow(val) {
    $("#deleteRowEdu" + val).remove();
    var newCount = val - 1;
    $("#rowLengthEdu").val(newCount);
    $("#btnMinusEdu" + newCount).removeAttr("disabled");
  }

</script>