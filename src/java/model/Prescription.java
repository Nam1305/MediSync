/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author DIEN MAY XANH
 */
public class Prescription {

    private int prescriptionId, appointmentId;
    private String medicineName, totalQuantity, dosage, note;

    public Prescription() {
    }

    public Prescription(int prescriptionId, int appointmentId, String medicineName, String totalQuantity, String dosage, String note) {
        this.prescriptionId = prescriptionId;
        this.appointmentId = appointmentId;
        this.medicineName = medicineName;
        this.totalQuantity = totalQuantity;
        this.dosage = dosage;
        this.note = note;
    }

    public int getPrescriptionId() {
        return prescriptionId;
    }

    public void setPrescriptionId(int prescriptionId) {
        this.prescriptionId = prescriptionId;
    }

    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }

    public String getMedicineName() {
        return medicineName;
    }

    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName;
    }

    public String getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(String totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    public String getDosage() {
        return dosage;
    }

    public void setDosage(String dosage) {
        this.dosage = dosage;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    @Override
    public String toString() {
        return "Prescription{" + "prescriptionId=" + prescriptionId + ", appointmentId=" + appointmentId + ", medicineName=" + medicineName + ", totalQuantity=" + totalQuantity + ", dosage=" + dosage + ", note=" + note + '}';
    }

    
    
}
