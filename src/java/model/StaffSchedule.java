package model;

import java.sql.Date;

public class StaffSchedule {
    private int staffId;
    private String name;
    private String departmentName;
    private Date startDate;
    private Date endDate;
    private int totalShifts;
    private String shiftList;

    // Constructor
    public StaffSchedule(int staffId, String name, String departmentName, 
                         Date startDate, Date endDate, int totalShifts, String shiftList) {
        this.staffId = staffId;
        this.name = name;
        this.departmentName = departmentName;
        this.startDate = startDate;
        this.endDate = endDate;
        this.totalShifts = totalShifts;
        this.shiftList = shiftList;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public int getTotalShifts() {
        return totalShifts;
    }

    public void setTotalShifts(int totalShifts) {
        this.totalShifts = totalShifts;
    }

    public String getShiftList() {
        return shiftList;
    }

    public void setShiftList(String shiftList) {
        this.shiftList = shiftList;
    }

    

}