namespace QLNhaSach
{
    partial class FormBaoCaoDS_SPHienCo
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
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.reportViewerBC = new Microsoft.Reporting.WinForms.ReportViewer();
            this.buttonBC_DSSPHienCo = new System.Windows.Forms.Button();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.groupBox1.SuspendLayout();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.reportViewerBC);
            this.groupBox1.Font = new System.Drawing.Font("Times New Roman", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox1.Location = new System.Drawing.Point(12, 107);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(1298, 610);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Hiển thị báo cáo";
            // 
            // reportViewerBC
            // 
            this.reportViewerBC.AutoSize = true;
            this.reportViewerBC.Location = new System.Drawing.Point(6, 25);
            this.reportViewerBC.Name = "reportViewerBC";
            this.reportViewerBC.Size = new System.Drawing.Size(1292, 579);
            this.reportViewerBC.TabIndex = 0;
            // 
            // buttonBC_DSSPHienCo
            // 
            this.buttonBC_DSSPHienCo.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.buttonBC_DSSPHienCo.Location = new System.Drawing.Point(491, 30);
            this.buttonBC_DSSPHienCo.Name = "buttonBC_DSSPHienCo";
            this.buttonBC_DSSPHienCo.Size = new System.Drawing.Size(170, 35);
            this.buttonBC_DSSPHienCo.TabIndex = 1;
            this.buttonBC_DSSPHienCo.Text = "TẠO BÁO CÁO";
            this.buttonBC_DSSPHienCo.UseVisualStyleBackColor = true;
            this.buttonBC_DSSPHienCo.Click += new System.EventHandler(this.buttonBC_DSSPHienCo_Click);
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.buttonBC_DSSPHienCo);
            this.groupBox2.Font = new System.Drawing.Font("Times New Roman", 9.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.groupBox2.Location = new System.Drawing.Point(12, 12);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(1298, 89);
            this.groupBox2.TabIndex = 2;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "MỤC TẠO BÁO CÁO";
            // 
            // FormBaoCaoDS_SPHienCo
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(1322, 729);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Name = "FormBaoCaoDS_SPHienCo";
            this.Text = "BÁO CÁO DANH SÁCH SẢN PHẨM HIỆN CÓ";
            this.Load += new System.EventHandler(this.FormBaoCaoThongKe_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.groupBox2.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private Microsoft.Reporting.WinForms.ReportViewer reportViewerBC;
        private System.Windows.Forms.Button buttonBC_DSSPHienCo;
        private System.Windows.Forms.GroupBox groupBox2;
    }
}