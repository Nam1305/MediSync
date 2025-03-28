package model;

import java.sql.Date;

public class StaffSchedule {
    private int staffId;
    private String name;
    private String departmentName;
    private Date startDate;
    private Date endDate;
    private int shift;

    public StaffSchedule(int staffId, String name, String departmentName, Date startDate, Date endDate, int shift) {
        this.staffId = staffId;
        this.name = name;
        this.departmentName = departmentName;
        this.startDate = startDate;
        this.endDate = endDate;
        this.shift = shift;
    }

    // Các getter và setter
    public int getStaffId() { return staffId; }
    public String getName() { return name; }
    public String getDepartmentName() { return departmentName; }
    public Date getStartDate() { return startDate; }
    public Date getEndDate() { return endDate; }
    public int getShift() { return shift; }
}