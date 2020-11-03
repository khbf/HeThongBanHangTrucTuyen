namespace QLNhaSach
{
    partial class FormBaoCaoDS_DHThanhCongTheoNgay
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.dateTimePicker_NDH = new System.Windows.Forms.DateTimePicker();
            this.label1 = new System.Windows.Forms.Label();
            this.buttonTaoBC = new System.Windows.Forms.Button();
            this.reportViewerBC = new Microsoft.Reporting.WinForms.ReportViewer();
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.groupBox2.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.dateTimePicker_NDH);
            this.groupBox2.Controls.Add(this.label1);
            this.groupBox2.Controls.Add(this.buttonTaoBC);
            this.groupBox2.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox2.Location = new System.Drawing.Point(17, 6);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(1298, 89);
            this.groupBox2.TabIndex = 4;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "MỤC TẠO BÁO CÁO";
            // 
            // dateTimePicker_NDH
            // 
            this.dateTimePicker_NDH.Format = System.Windows.Forms.DateTimePickerFormat.Short;
            this.dateTimePicker_NDH.Location = new System.Drawing.Point(334, 43);
            this.dateTimePicker_NDH.Name = "dateTimePicker_NDH";
            this.dateTimePicker_NDH.Size = new System.Drawing.Size(130, 22);
            this.dateTimePicker_NDH.TabIndex = 3;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Times New Roman", 11.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(223, 43);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(105, 17);
            this.label1.TabIndex = 2;
            this.label1.Text = "Ngày đặt hàng:";
            // 
            // buttonTaoBC
            // 
            this.buttonTaoBC.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.buttonTaoBC.Location = new System.Drawing.Point(511, 35);
            this.buttonTaoBC.Name = "buttonTaoBC";
            this.buttonTaoBC.Size = new System.Drawing.Size(170, 35);
            this.buttonTaoBC.TabIndex = 1;
            this.buttonTaoBC.Text = "TẠO BÁO CÁO";
            this.buttonTaoBC.UseVisualStyleBackColor = true;
            this.buttonTaoBC.Click += new System.EventHandler(this.buttonTaoBC_Click);
            // 
            // reportViewerBC
            // 
            this.reportViewerBC.Location = new System.Drawing.Point(6, 25);
            this.reportViewerBC.Name = "reportViewerBC";
            this.reportViewerBC.Size = new System.Drawing.Size(1286, 527);
            this.reportViewerBC.TabIndex = 0;
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.reportViewerBC);
            this.groupBox1.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(17, 101);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(1303, 558);
            this.groupBox1.TabIndex = 3;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Hiển thị báo cáo";
            // 
            // FormBaoCaoDS_DHThanhCongTheoNgay
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1332, 671);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Name = "FormBaoCaoDS_DHThanhCongTheoNgay";
            this.Text = "BÁO CÁO DANH SÁCH ĐƠN HÀNG ĐÃ ĐƯỢC GIAO DỊCH THÀNH CÔNG THEO NGÀY";
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.groupBox1.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.DateTimePicker dateTimePicker_NDH;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button buttonTaoBC;
        private Microsoft.Reporting.WinForms.ReportViewer reportViewerBC;
        private System.Windows.Forms.GroupBox groupBox1;
    }
}