enum UserTypeEnum {
  patient("patient"),
  doctor("doctor");

  final String value;

  const UserTypeEnum(this.value);

  static UserTypeEnum fromString(String value) {
    switch (value) {
      case "patient":
        return UserTypeEnum.patient;
      case "doctor":
        return UserTypeEnum.doctor;
      default:
        return UserTypeEnum.patient;
    }
  }
}

// PaymentStatus (pending(0), accepted(1), rejected, canceled , finished , waiting)

// UserTypeEnum.patient.value;
