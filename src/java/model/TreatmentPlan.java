/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DIEN MAY XANH
 */
public class TreatmentPlan {
    
    private int treatmentId, appointmentId;
    private String symptoms, diagnosis, testResult, plan, followUp; 

    public TreatmentPlan() {
    }

    public TreatmentPlan(int treatmentId, int appointmentId, String symptoms, String diagnosis, String testResult, String plan, String followUp) {
        this.treatmentId = treatmentId;
        this.appointmentId = appointmentId;
        this.symptoms = symptoms;
        this.diagnosis = diagnosis;
        this.testResult = testResult;
        this.plan = plan;
        this.followUp = followUp;
    }

    public int getTreatmentId() {
        return treatmentId;
    }

    public void setTreatmentId(int treatmentId) {
        this.treatmentId = treatmentId;
    }

    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }

    public String getSymptoms() {
        return symptoms;
    }

    public void setSymptoms(String sysptoms) {
        this.symptoms = sysptoms;
    }

    public String getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public String getTestResult() {
        return testResult;
    }

    public void setTestResult(String testResult) {
        this.testResult = testResult;
    }

    public String getPlan() {
        return plan;
    }

    public void setPlan(String plan) {
        this.plan = plan;
    }

    public String getFollowUp() {
        return followUp;
    }

    public void setFollowUp(String followUp) {
        this.followUp = followUp;
    }

    @Override
    public String toString() {
        return "TreatmentPlan{" + "treatmentId=" + treatmentId + ", appointmentId=" + appointmentId + ", sysptoms=" + symptoms + ", diagnosis=" + diagnosis + ", testResult=" + testResult + ", plan=" + plan + ", followUp=" + followUp + '}';
    }
    
}
