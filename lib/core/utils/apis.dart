class ApiEndPoints {
  static const String Base_Url = "https://OmniCRM.1800erp.com/";

  static const String login = "api/method/login";
  static const String leads = "api/resource/CRM Lead?";
  static const String convertLeadToDeal =
      "/api/method/crm.fcrm.doctype.crm_lead.crm_lead.convert_to_deal";
  static const String updateLeadStatus = "/api/method/frappe.client.set_value";
  static const String deleteLead =
      "/api/method/frappe.desk.reportview.delete_items";
  static const String createTag =
      "/api/method/frappe.desk.doctype.tag.tag.add_tag";
  static const String deleteTag =
      "/api/method/frappe.desk.doctype.tag.tag.remove_tag";
}
